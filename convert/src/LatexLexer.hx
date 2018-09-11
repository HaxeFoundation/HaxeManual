import haxe.io.Eof;
import hxparse.Position;
import LatexToken;
import LatexCommand;

enum LexerErrorMsg {
	UnterminatedEnvironment;
}

class LexerError {
	public var msg:LexerErrorMsg;
	public var pos:Position;
	public function new(msg, pos) {
		this.msg = msg;
		this.pos = pos;
	}
}

class LatexLexer extends hxparse.Lexer implements hxparse.RuleBuilder {

	static public var customEnvironments:Map<String, String->String> = new Map();

	static var commands = @:mapping(1) LatexCommand;

	static var buf = new StringBuf();
	static var lastCustomEnvironment:String;

	static public var tok = @:rule [
		"[" => TBkOpen,
		"]" => TBkClose,
		"{" => TBrOpen,
		"}" => TBrClose,
		"\\\\begin{[a-zA-Z]+}" => {
			var name = lexer.current.substr(7, lexer.current.length - 8);
			if (customEnvironments.exists(name)) {
				lastCustomEnvironment = name;
				buf = new StringBuf();
				var pmin = lexer.curPos();
				try lexer.token(customEnvironment) catch (e:Eof) throw new LexerError(UnterminatedEnvironment, pmin);
				TCustomEnvironment(name, buf.toString(), customEnvironments.get(name));
			} else {
				TBegin(name);
			}
		},
		"\\\\end{[a-zA-Z]+}" => TEnd(lexer.current.substr(5, lexer.current.length - 6)),
		"\\\\[a-zA-Z]+" => {
			var kwd = lexer.current.substr(1);
			if (commands.exists(kwd)) TCommand(commands.get(kwd))
			else TCustomCommand(kwd);
		},
		"(\n|\r\n)" => {
			//lexer.line++;
			TNewline;
		},
		"\t" => TTab,
		"$" => TDollar,
		"\\\\$" => TDollarLiteral,
		"&" => TAmp,
		"\\\\&" => TText("&"),
		"%" => lexer.token(comment),
		"\\\\%" => TText("%"),
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

	static public var customEnvironment = @:rule [
		// TODO better/saner regexps
		"[^\\\\]+" => {
			buf.add(lexer.current);
			lexer.token(customEnvironment);
		},
		"\\\\[a-zA-Z]+" => {
			buf.add(lexer.current);
			lexer.token(customEnvironment);
		},
		"\\\\end{[a-zA-Z]+}" => {
			var name = lexer.current.substr(5, lexer.current.length - 6);
			if (name == lastCustomEnvironment) {
				lexer.curPos().pmax;
			} else {
				buf.add(lexer.current);
				lexer.token(customEnvironment);
			}
		}
	];
}
