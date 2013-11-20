import haxe.ds.GenericStack;

import LatexToken;
import LatexCommand;

using StringTools;

enum State {
	/**
		Section is not meant to have any content (for aggregating chapters/sections).
	**/
	NoContent;
	/**
		Section is new and was not edited yet (default)
	**/
	New;
	/**
		Section was edited in the past but got modified afterwards.
	**/
	Modified;
	/**
		Section is edited.
	**/
	Edited;
}

typedef Section = {
	title: String,
	label: String,
	content: String,
	sub: Array<Section>,
	index: Int,
	id: String,
	state: State
}

enum ListMode {
	Itemize;
	Enumerate(c:Int);
	Description;
}

enum LabelKind {
	Section(sec:Section);
	Item(i:Int);
	Definition;
}

typedef Label = {
	name: String,
	kind: LabelKind
}

class LatexParser extends hxparse.Parser<LatexLexer, LatexToken> implements hxparse.ParserBuilder {
	public var labelMap:Map<String, Label>;
	public var definitionMap:Map<String, String>;
	public var todos:Array<String>;
	
	var sections:Array<Section>;
	var lastSection:Section;
	var buffer:StringBuf;
	var codeMode:Bool;
	var exprMode:Bool;
	var tableMode:Bool;
	var hlineCount:Int;
	var tableFieldCount:Int;
	var listMode:GenericStack<ListMode>;
	var lastLabelTarget:LabelKind;
	
	public function new(input, sourceName) {
		super(new LatexLexer(input, sourceName), LatexLexer.tok);
		buffer = new StringBuf();
		todos = [];
		sections = [];
		labelMap = new Map();
		definitionMap = new Map();
		listMode = new GenericStack<ListMode>();
		codeMode = false;
		exprMode = false;
		tableMode = false;
	}
	
	public function parse() {
		header();
		document();
		lastSection.content = buffer.toString();
		return sections;
	}
	
	function header() {
		while(true) {
			switch stream {
				case [TBegin("document")]: break;
				case [TEof]: throw "Found eof before \\begin{document}";
				case _: junk();
			}
		}
	}
	
	function document() {
		while(true) {
			switch stream {
				case [s = text2()]: buffer.add(s);
				
				// skip
				case [TCommand(CTitle), TBrOpen, s = text(), TBrClose]:
				case [TCommand(CAuthor), TBrOpen, s = text(), TBrClose]:
				case [TCommand(CDate), TBrOpen, TCommand(CToday), TBrClose]:
				case [TCommand(CClearpage)]:
				case [TCommand(CTableofcontents)]:
				case [TCommand(CMaketitle)]:
				case [TCustomCommand("todototoc")]:
				case [TCustomCommand("listoftodos")]:

				
				// format
				case [TBegin("center")]:
				case [TEnd("center")]:
				case [TBegin("tabular"), _ = popt(tableFormat)]:
					tableMode = true;
					hlineCount = 0;
					tableFieldCount = 0;
				case [TEnd("tabular")]:
					tableMode = false;
					
				// code
				case [TBegin("lstlisting")]:
					codeMode = true;
					buffer.add("```haxe");
				case [TEnd("lstlisting")]:
					codeMode = false;
					buffer.add("```");
				case [TBegin("figure")]:
					// TODO
				case [TEnd("figure")]:
					// TODO
				case [TCommand(CCentering)]:
				case [TCommand(CIncludegraphics), options = popt(bracketArg), TBrOpen, s = text(), TBrClose]:
					// TODO
				case [TCommand(CCaption), TBrOpen, s = text(), TBrClose]:
					// TODO
				case [TCustomCommand("haxe"), options = popt(bracketArg), TBrOpen, s = text(), TBrClose]:
					var f = sys.io.File.getContent(s);
					var validate = false;
					var f = if (options == null) {
						f;
					} else {
						var config = options.split(",");
						var firstline = 0;
						var lastline = 0;
						for (cfg in config) {
							var kv = cfg.split("=");
							switch(kv[0]) {
								case "firstline": firstline = Std.parseInt(kv[1]);
								case "lastline": lastline = Std.parseInt(kv[1]);
								case "nocompile": validate = false;
							}
						}
						if (firstline > 0 && lastline > 0) {
							f = f.replace("\r", "");
							var lines = f.split("\n");
							var tcount = 0;
							while(true) {
								if (lines[firstline - 1].charCodeAt(tcount) != "\t".code) break;
								tcount++;
							}
							[for (i in firstline - 1...lastline) lines[i].substr(tcount)].join("\n");
						} else {
							f;
						}
					}
					if (validate) testCompile(s);
					buffer.add("```haxe\n");
					buffer.add(f);
					buffer.add("\n```");
									
				// custom
				case [TCustomCommand("define"), subject = popt(bracketArg), TBrOpen, s = text(), TBrClose, TBrOpen, s2 = text2(), TBrClose]:
					definitionMap[s] = s2;
					labelMap['def:$s'] = mkLabel(s, Definition);
					buffer.add('> ##### Define: $s\n');
					buffer.add('>\n');
					s2 = s2.replace("\r", "").split("\n").join("\n> ");
					buffer.add('> $s2');
					buffer.add("\n");
				case [TCustomCommand("trivia"), title = popt(bracketArg), TBrOpen, s = text(), TBrClose, TBrOpen, s2 = text2(), TBrClose]:
					buffer.add('> ##### Trivia: $s\n');
					buffer.add('>\n');
					s2 = s2.replace("\r", "").split("\n").join("\n> ");
					buffer.add('> $s2');
				case [TCustomCommand("todo"), options = popt(bracketArg), TBrOpen, s = text(), TBrClose]:
					todos.push('${lastSection.id} - ${lastSection.title}: $s');
					buffer.add('\n>TODO: $s\n\n');
				case [TCustomCommand("missingfigure"), TBrOpen, s = text(), TBrClose]: buffer.add('> $s');
				case [TCustomCommand("since"), TBrOpen, s = text(), TBrClose]: buffer.add('##### since Haxe $s\n\n');
				case [TCustomCommand("state"), TBrOpen, s = text(), TBrClose]:
					var state = switch(s) {
						case "Modified": Modified;
						case "Edited": Edited;
						case "NoContent": NoContent;
						case _: throw 'Invalid state string: $s';
					}
					lastSection.state = state;
				// section
				case [TCommand(CPart), TBrOpen, s = text(), TBrClose]:
					// TODO: handle this
				case [TCommand(CChapter), TBrOpen, s = text(), TBrClose]:
					sections.push(mkSection(s, null, sections.length + 1));
				case [TCommand(CSection), TBrOpen, s = text(), TBrClose]:
					var sec = sections[sections.length - 1];
					sec.sub.push(mkSection(s, sec, sec.sub.length + 1));
				case [TCommand(CSubsection), TBrOpen, s = text(), TBrClose]:
					var sec = sections[sections.length - 1].sub;
					var sec = sec[sec.length - 1];
					sec.sub.push(mkSection(s, sec, sec.sub.length + 1));
									
				// misc
				case [TCommand(CMulticolumn), TBrOpen, _ = text(), TBrClose, TBrOpen, _ = text(), TBrClose, TBrOpen, s = text(), TBrClose]:
					buffer.add('\n##### $s\n');
					hlineCount = 0;
				
				case [TEnd("document")]: break;
				case [TEof]: throw "Found eof before \\end{document}";
			}
		}
	}
	
	function text() {
		var s = _text();
		if (s == null) noMatch();
		var s2 = popt(text);
		return if (s2 == null) s else s + s2;
	}
	
	function _text() {
		return switch stream {
			case [TText(s)]: s;
			case [TTab]:
				codeMode ? "\t" : "";
			case [TDollarLiteral]: "$";
			case [TDollar]: codeMode ? "$" : "";
			case [TAmp]:
				if (tableMode && !exprMode) {
					if (hlineCount == 1) tableFieldCount++;
					" |";
				} else {
					"&";
				}
			case [TCommand(CTextasciitilde)]: "~";
			case [TCommand(CTextbackslash)]: "\\\\";
			case [TCommand(CEmph), TBrOpen, s = text(), TBrClose]: '**$s**';
			case [TCommand(CTextwidth)]: "";
			//I think \it{} is obsolete.  Added \textit{}
			case [TCommand(CTextit), TBrOpen, s = text(), TBrClose]:'*$s*';
			case [TCommand(CIt), TBrOpen, s = text(), TBrClose]: '*$s*';
			case [TCommand(CTextbf), TBrOpen, s = text(), TBrClose]:'**$s**';
			case [TCommand(CTextsuperscript), TBrOpen, s = text(), TBrClose]:'<sup>$s</sup>';
			case [TBrOpen && codeMode]: "{";
			case [TBrClose && codeMode]: "}";
			case [TBkOpen && (codeMode || exprMode)]: "[";
			case [TBkClose && (codeMode || exprMode)]: "]";
			case [TCommand(CLeft)]: "";
			case [TCommand(CRight)]: "";
			case [TCustomCommand("target"), TBrOpen, s = text(), TBrClose]: s;
			case [TCustomCommand("expr")]:
				exprMode = true;
				var s = switch stream {
					case [TBrOpen, s = text(), TBrClose]:
						if (tableMode) {
							s = s.htmlEscape().replace("|", "&#124;");
							'<code>$s</code>';
						} else {
							'`$s`';
						}
					case _: unexpected();
				}
				exprMode = false;
				s;
			case [TCommand(CTexttt), TBrOpen, s = text(), TBrClose]: '`$s`';
			case [TCustomCommand("type"), TBrOpen, s = text(), TBrClose]: '`$s`';
			case [TCustomCommand("ic"), TBrOpen, s = text(), TBrClose]: '`$s`';
			case [s = ref()]: s;
			case [TCustomCommand("href"), TBrOpen, s1 = text(), TBrClose, TBrOpen, s2 = text(), TBrClose]: '[$s1]($s2)';
			case [TCommand(CUrl), TBrOpen, s = text(), TBrClose]: '[$s]($s)';
			case [TCommand(CLabel), TBrOpen, s = text(), TBrClose]:
				var name = switch(lastLabelTarget) {
					case Section(sec):
						lastSection.label = s;
						sec.title;
					case Item(i):
						"" + i;
					case Definition:
						throw false;
				}
				labelMap[s] = mkLabel(name, lastLabelTarget);
				"";
			case [TCommand(CHline)]:
				if (tableMode) {
					hlineCount++;
					if (hlineCount == 2) {
						[for (i in 0...tableFieldCount + 1) "---"].join(" | ") + "\n";
					} else {
						"";
					}
				} else {
					"---\n";
				}
			case [TNewline]: tableMode ? "" : "\n";
			case [TDoubleBackslash]: "\n";
			//These commands can have optional, empy braces after them (for spacing purposes).
			case [TCommand(CTextless), dummy = popt(emptyBraces)]: "&lt;";
			case [TCommand(CTextgreater), dummy = popt(emptyBraces)]: "&gt;";
			case [TCommand(CLdots), dummy = popt(emptyBraces)]: "...";
			case [TCommand(CTextasciicircum)]: "^";
		}
	}
	
	function text2() {
		var s = _text2();
		if (s == null) noMatch();
		var s2 = popt(text2);
		return if (s2 == null) s else s + s2;
	}
	
	function _text2() {
		return switch stream {
			// list
			case [TBegin("itemize")]:
				listMode.add(Itemize);
				"\n";
			case [TBegin("description")]:
				listMode.add(Description);
				"\n";
			case [TBegin("enumerate")]:
				listMode.add(Enumerate(1));
				lastLabelTarget = Item(1);
				"\n";
			case [TCommand(CItem), subject = popt(bracketArg), s = text()]:
				var bullet = switch(listMode.first()) {
					case Enumerate(c):
						listMode.pop();
						listMode.add(Enumerate(c + 1));
						lastLabelTarget = Item(c + 1);
						'$c.';
					case Description:
						'* $subject';
					case Itemize:
						"*";
				}
				'$bullet$s';
			case [TEnd("itemize")]:
				listMode.pop();
				"\n";
			case [TEnd("description")]:
				listMode.pop();
				"\n";
			case [TEnd("enumerate")]:
				listMode.pop();
				"\n";
			// TODO
			case [TCommand(CFootnote), TBrOpen, s = text(), TBrClose]: "";
			case [t = _text()]:
				t;
		}
	}
	
	function ref() {
		return switch stream {
			case [TCommand(CRef), TBrOpen, s = text(), TBrClose]: '~~~$s~~~';
			case [TCustomCommand("Fullref"), TBrOpen, s = text(), TBrClose]: '~~~$s~~~';
			case [TCustomCommand("tref"), TBrOpen, s1 = text(), TBrClose, TBrOpen, s2 = text(), TBrClose]: '[$s1](~~$s2~~)';
		}
	}
	
	function tableFormat() {
		return switch stream {
			case [TBrOpen, s = text(), TBrClose]: s;
			case _: null;
		}
	}
	
	function bracketArg() {
		return switch stream {
			case [TBkOpen, s = text(), TBkClose]: s;
		}
	}

	function emptyBraces(){
		return switch stream {
			case [TBrOpen, TBrClose]: "";
		}
	}

	
	function popt<T>(f:Void->T):Null<T> {
		return switch stream {
			case [v = f()]: v;
			case _: null;
		}
	}
	
	function mkSection(title:String, parent:Section, index:Int) {
		if (lastSection != null) {
			lastSection.content = buffer.toString();
			buffer = new StringBuf();
		}
		var id = (parent != null ? parent.id + "." : "") + index;
		lastSection = {title: title, label: null, content: "", sub: [], index:index, id: id, state: New};
		lastLabelTarget = Section(lastSection);
		return lastSection;
	}
	
	function mkLabel(name:String, kind:LabelKind) {
		return {
			name: name,
			kind: kind
		}
	}
	
	function testCompile(path:String) {
		var path = new haxe.io.Path(path);
		var p = new sys.io.Process("haxe", ["-main", path.file, "-cp", "assets", "-x", "test"]);
		p.stdout.readAll();
		var err = p.stderr.readAll();
		if (p.exitCode() != 0) trace('Failed: $path\n$err');
		
	}
}
