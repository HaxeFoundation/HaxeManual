import LatexParser;

using StringTools;
using Lambda;

typedef SectionInfo = {
	all: Array<Section>,
	noContent: Array<Section>
}

class Main {

	static function main() {
		var config:Config = {
			sourceDirectory: ".",
			sourceFile: null,
			output: new haxe.io.Path("../content/")
		}

		var handler = hxargs.Args.generate([
			@doc("Sets the input directory")
			"-i" => function(directory:String) {
				config.sourceDirectory = directory;
			},
			@doc("Sets the output directory")
			_ => function(file:String) {
				config.sourceFile = file;
			}
		]);
		handler.parse(Sys.args());
		if (config.sourceFile == null) {
			Sys.println('Missing source file');
			Sys.println(handler.getDoc());
			Sys.exit(1);
		}
		new Main(config);
	}

	var parser:LatexParser;
	var out:String;
	var config:Config;
	var sectionInfo:SectionInfo;

	function new(config:Config) {
		this.config = config;
		Sys.setCwd(config.sourceDirectory);
		var sections = parse(config.sourceFile);
		out = config.output.dir;

		sectionInfo = collectSectionInfo(sections);

		function generateTitleString(sec:Section, prefix = "##") {
			return '<!--label:${sec.label}-->\n$prefix ${sec.title}\n\n';
		}

		for (sec in sectionInfo.all) {
			if (sec.parent == null) {
				if (sec.content.length == 0) {
					sec.content = generateTitleString(sec) + "<!--subtoc-->";
				} else {
					sec.content = generateTitleString(sec) + process(sec.content);
				}
				sec.sub.map((function addSub(sub, depth) {
					if (sub.label == "target-cpp-defines") {
						var raw = sys.io.File.getContent('../hxcpp-docs/build_xml/Defines.md');
						var lines = raw.replace("\r", "").replace("\n###", "\n#####").split("\n");
						sec.content += '<!--label:target-cpp-defines-->\n#### ${lines[0]}\n\n' + lines.slice(2).join("\n");
						return;
					}
					if (sub.label == "target-cpp-file-format") {
						var raw = sys.io.File.getContent('../hxcpp-docs/build_xml/README.md');
						var lines = raw.replace("\r", "").replace("\n###", "\n#####").split("\n");
						sec.content += '<!--label:target-cpp-file-format-->\n#### ${lines[0]}\n\n' + lines.slice(2).join("\n");
						for (f in [
							"build_xml/TopLevel",
							"build_xml/Files",
							"build_xml/Tags",
							"build_xml/Targets",
							"build_xml/Compiler",
							"build_xml/Linker",
							"build_xml/Stripper",
							"build_xml/HaxeTarget",
							"build_xml/XmlInjection",
						]) {
							var raw = sys.io.File.getContent('../hxcpp-docs/$f.md');
							var lines = raw.replace("\r", "").replace("\n###", "\n#####").split("\n");
							sec.content += '<!--label:target-cpp-${f.replace("/", "-")}-->\n##### ${lines[0]}\n\n' + lines.slice(2).join("\n");
						}
						return;
					}

					sec.content += "\n\n" + generateTitleString(sub, "".rpad("#", depth + 3));
					if (sub.content.length == 0) {
						sec.content += "<!--subtoc-->";
					} else {
						sec.content += process(sub.content);
					}
					sub.sub.map(addSub.bind(_, depth + 1));

					// patch hxcpp docs in
					sec.content += "\n\n";
					if (sub.label == "target-cpp-pointers") {
						for (f in [
							"CompileCache",
							"ThreadsAndStacks",
						]) {
							var raw = sys.io.File.getContent('../hxcpp-docs/$f.md');
							var lines = raw.replace("\r", "").replace("\n###", "\n#####").split("\n");
							sec.content += '<!--label:target-cpp-${f.replace("/", "-")}-->\n####${f.startsWith("build_xml") ? "#" : ""} ${lines[0]}\n\n' + lines.slice(2).join("\n");
						}
					}
				}).bind(_, 0));
			}
		}

		//unlink(out);
		//sys.FileSystem.createDirectory(out);

		var topLevelIndex = 1;
		for (i in 0...sectionInfo.all.length) {
			var sec = sectionInfo.all[i];
			if (sec.parent != null) continue;
			sys.io.File.saveContent('$out/${StringTools.lpad('${topLevelIndex++}', "0", 2)}-${url(sec)}.md', sec.content + "\n");
		}
	}

	function parse(source:String) {
		LatexLexer.customEnvironments["flowchart"] = FlowchartHandler.handle.bind(config);
		var input = byte.ByteData.ofString(sys.io.File.getContent(source));
		parser = new LatexParser(input, source, config);
		var sections = hxparse.Utils.catchErrors(input, parser.parse);
		return sections;
	}

	function collectSectionInfo(sections:Array<Section>):SectionInfo {
		var allSections = [];
		var noContent = [];

		function add(sec:Section) {
			if (sec.label == null) {
				throw 'Missing label: ${sec.title}';
			}
			if(sec.content.length == 0) {
				if (sec.sub.length == 0) {
					return;
				}
			}
			allSections.push(sec);
			for (sub in sec.sub) {
				add(sub);
			}
		}
		for (sec in sections) {
			add(sec);
		}
		return {
			all: allSections,
			noContent: noContent
		}
	}

	function isLinkable(sec:Section) {
		return !sectionInfo.noContent.has(sec);
	}

	function link(sec:Section) {
		if (!isLinkable(sec)) {
			return '[${sec.title}](#)';
		}
		return '[${sec.title}](${url(sec)})';
	}

	function process(s:String):String {
		function labelUrl(label:Label) {
			return switch(label.kind) {
				case Section(sec):
					if (isLinkable(sec)) {
						url(sec);
					} else {
						'#';
					}
				case Definition:
					escapeAnchor(label.name);
				case Item(i): "" + i;
				case Paragraph(sec, name): '${url(sec)}#${escapeAnchor(name)}';
			}
		}
		function labelLink(label:Label) {
			return switch(label.kind) {
				case Section(sec): link(sec);
				case Definition: '[${label.name}](${labelUrl(label)})';
				case Item(i): "" + i;
				case Paragraph(sec, name): '[$name](${url(sec)}#${escapeAnchor(name)})';
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

	function url(sec:Section) {
		return sec.label;
	}

	static function escapeFileName(s:String) {
		return s.replace("?", "").replace("/", "_").replace(" ", "_");
	}

	static function escapeAnchor(s:String) {
		return s.toLowerCase().replace(" ", "-").replace(".", "");
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
