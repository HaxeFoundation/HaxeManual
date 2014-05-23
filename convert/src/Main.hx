import LatexParser;

using StringTools;
using Lambda;

typedef SectionInfo = {
	all: Array<Section>,
	unreviewed: Array<String>,
	modified: Array<String>,
	noContent: Array<Section>
}

class Main {
	static function main() {
		new Main();
	}

	var parser:LatexParser;
	var out:String;
	var sectionInfo:SectionInfo;

	function new() {
		Sys.setCwd("../");
		var sections = parse();
		var linkBase = "https://github.com/HaxeFoundation/HaxeManual/blob/master/";
		out = "md/manual";
		unlink(out);
		sys.FileSystem.createDirectory(out);

		sectionInfo = collectSectionInfo(sections);

		for (sec in sectionInfo.all) {
			if (sec.content.length == 0 && sec.sub.length > 0) {
				sec.content = sec.sub.map(function(sec) return sec.id + ": " +link(sec)).join("\n\n");
			} else {
				sec.content = process(sec.content);
			}
		}

		for (i in 0...sectionInfo.all.length) {
			var sec = sectionInfo.all[i];
			var content = '## ${sec.id} ${sec.title}\n\n' + sec.content;
			content += "\n\n---";
			if (i != 0) content += '\n\nPrevious section: ${link(sectionInfo.all[i - 1])}';
			if (i != sectionInfo.all.length - 1) content += '\n\nNext section: ${link(sectionInfo.all[i + 1])}';
			var fileAndLines = '${sec.source.file}#L${sec.source.lineMin}-${sec.source.lineMax}';
			content += '\n\nContribute: [fileAndLines]($linkBase$fileAndLines)';
			sys.io.File.saveContent('$out/${url(sec)}', content);
			Reflect.deleteField(sec, "content");
		}

		generateDictionary();
		generateTodo(sectionInfo);
		generateDotMap(sections);

		sys.io.File.saveContent('$out/sections.txt', haxe.Json.stringify(sections));
	}

	function parse() {
		LatexLexer.customEnvironments["flowchart"] = FlowchartHandler.handle;
		var input = byte.ByteData.ofString(sys.io.File.getContent("HaxeDoc.tex"));
		parser = new LatexParser(input, "HaxeDoc.tex");
		var sections = try {
			parser.parse();
		} catch(e:hxparse.NoMatch<Dynamic>) {
			throw e.pos.format(input) + ": Unexpected " +e.token;
		} catch(e:hxparse.Unexpected<Dynamic>) {
			throw e.pos.format(input) + ": Unexpected " +e.token;
		}
		return sections;
	}

	function collectSectionInfo(sections:Array<Section>):SectionInfo {
		var allSections = [];
		var unreviewed = [];
		var modified = [];
		var noContent = [];

		function add(sec:Section) {
			if (sec.label == null) {
				throw 'Missing label: ${sec.title}';
			}
			if(sec.content.length == 0) {
				if (sec.state != NoContent) {
					noContent.push(sec);
				}
				if (sec.sub.length == 0) {
					return;
				}
			} else switch(sec.state) {
				case New: unreviewed.push('${sec.id} - ${sec.title}');
				case Modified: modified.push('${sec.id} - ${sec.title}');
				case Reviewed | NoContent:
			}
			allSections.push(sec);
			for (sec in sec.sub) {
				add(sec);
			}
		}
		for (sec in sections) {
			add(sec);
		}
		return {
			all: allSections,
			unreviewed: unreviewed,
			noContent: noContent,
			modified: modified
		}
	}

	function generateDictionary() {
		var a = [for (k in parser.definitionMap.keys()) {k:k, v:parser.definitionMap[k]}];
		a.sort(function(v1, v2) return Reflect.compare(v1.k.toLowerCase(), v2.k.toLowerCase()));
		sys.io.File.saveContent('$out/dictionary.md', a.map(function(v) return '##### ${v.k}\n${process(v.v)}').join("\n\n"));
	}

	function generateTodo(sectionInfo:SectionInfo) {
		var todo = "This file is generated, do not edit!\n\n"
			+ "Todo:\n" + parser.todos.join("\n") + "\n\n"
			+ "Missing Content:\n" + sectionInfo.noContent.map(function(sec) return '${sec.id} - ${sec.title}').join("\n") + "\n\n"
			+ "Unreviewed:\n" + sectionInfo.unreviewed.join("\n") + "\n\n"
			+ "Modified:\n" + sectionInfo.modified.join("\n");
		sys.io.File.saveContent('todo.txt', todo);
	}

	function generateDotMap(sections:Array<Section>) {
		var graph = new dot.Graph();
		graph.global([FontName("Palatino")]);
		var root = graph.node([Label("Haxe Manual")]);
		function connect(source:dot.Node, target:Section) {
			var node = graph.node([Label(target.title), Href(url(target))]);
			source.connect(node, []);
			for (sub in target.sub) {
				connect(node, sub);
			}
		}
		for (sec in sections) {
			connect(root, sec);
		}
		var code = graph.getDotCode();
		sys.io.File.saveContent('toc.sv', code);
	}

	function link(sec:Section) {
		if (sectionInfo.noContent.has(sec)) {
			return '[${sec.title}](#)';
		}
		return '[${sec.title}](${url(sec)})';
	}

	function process(s:String):String {
		function labelUrl(label:Label) {
			return switch(label.kind) {
				case Section(sec): url(sec);
				case Definition: 'dictionary.md#${escapeAnchor(label.name)}';
				case Item(i): "" + i;
			}
		}
		function labelLink(label:Label) {
			return switch(label.kind) {
				case Section(sec): link(sec);
				case Definition: '[${label.name}](${escapeAnchor("dictionary.md#" + label.name)})';
				case Item(i): "" + i;
			}
		}
		function map(r, f) {
			var i = r.matched(1);
			if (!parser.labelMap.exists(i)) {
				trace('Warning: No such label $i');
				return i;
			}
			return f(parser.labelMap[i]);
		}
		var s1 = ~/~~~([^~]+)~~~/g.map(s, map.bind(_, labelLink));
		return ~/~~([^~]+)~~/g.map(s1, map.bind(_, labelUrl));
	}

	static function escapeFileName(s:String) {
		return s.replace("?", "").replace("/", "_").replace(" ", "_");
	}

	static function escapeAnchor(s:String) {
		return s.toLowerCase().replace(" ", "-");
	}

	static function url(sec:Section) {
		return sec.label + ".md";
	}

	static function unlink(path:String) {
		if(sys.FileSystem.exists(path)) {
			if(sys.FileSystem.isDirectory(path)) {
				for(entry in sys.FileSystem.readDirectory(path))  {
					unlink( path + "/" + entry );
				}
				sys.FileSystem.deleteDirectory(path);
			}
			else {
				sys.FileSystem.deleteFile(path);
			}
		}
	}
}
