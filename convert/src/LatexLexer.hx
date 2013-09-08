import LatexToken;
import LatexCommand;

class LatexLexer extends hxparse.Lexer implements hxparse.RuleBuilder {
	
	static var commands = @:mapping(1) LatexCommand;
	
	static public var tok = @:rule [
		"[" => TBkOpen,
		"]" => TBkClose,
		"{" => TBrOpen,
		"}" => TBrClose,
		"\\\\begin{[a-zA-Z]+}" => TBegin(lexer.current.substr(7, lexer.current.length - 8)),
		"\\\\end{[a-zA-Z]+}" => TEnd(lexer.current.substr(5, lexer.current.length - 6)),
		"\\\\[a-zA-Z]+" => {
			var kwd = lexer.current.substr(1);
			if (commands.exists(kwd)) TCommand(commands.get(kwd))
			else TCustomCommand(kwd);
		},
		"(\n|\r\n)" => {
			lexer.line++;
			TNewline;
		},
		"\t" => TTab,
		"$" => TDollar,
		"&" => TAmp,
		"\\\\&" => TText("&"),
		"\\\\$" => TText("$"),
		"%" => lexer.token(comment),
		"\\\\$" => TText("%"),
		"\\\\\\\\" => TDoubleBackslash,
		"``" => TText('"'),
		"''" => TText('"'),
		"'" => TText("'"),
		"`" => TText("`"),
		"\\\\[^\\\\]" => TText(lexer.current.substr(1)),
		"\\\\^{e}" => TText("ê"),
		"[^\\\\{}\\[\\]\n\r\t$%&\\`']+" => TText(lexer.current),
		"" => TEof,
	];
	
	static public var comment = @:rule [
		"(\n|\r\n)" => lexer.token(tok),
		"[^\n\r]" => lexer.token(comment)
	];
}