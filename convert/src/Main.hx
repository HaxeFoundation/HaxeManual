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

	static inline var linkPrefix = #if epub "#" #else "" #end;

	static function main() {
		var config = {
			sourceDirectory: ".",
			sourceFile: null,
			outputDirectory: "output",
			omitIds: false,
		}

		var handler = hxargs.Args.generate([
			@doc("Sets the input directory")
			"-i" => function(directory:String) {
				config.sourceDirectory = directory;
			},
			@doc("Sets the input file")
			"-o" => function(directory:String) {
				config.outputDirectory = directory;
			},
			@doc("Omit chapter and section IDs")
			"--omit-ids" => function() {
				config.omitIds = true;
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
		out = config.outputDirectory;

		sectionInfo = collectSectionInfo(sections);

		for (sec in sectionInfo.all) {
			var subToc = makeSubToc(sec);
			if (sec.content.length == 0 && sec.sub.length > 0) {
				sec.content = subToc;
			} else {
				sec.content = process(sec.content);
			}

			sec.content = sec.content.replace("~subtoc~", subToc);
		}

		function generateTitleString(sec:Section, prefix = "##") {
			return
				#if epub '<a id="${url(sec)}"></a>\n' + #end
				'$prefix ${sec.id.length > 0 ? sec.id + " " : ""}${sec.title}\n\n';
		}

		for (sec in sectionInfo.all) {
			if (sec.flags["fold"] == "true") {
				for (sub in sec.sub) {
					sec.content += "\n\n" + generateTitleString(sub, "###") + sub.content;
					sectionInfo.all.remove(sub);
					Reflect.deleteField(sub, "content");
				}
			}
		}

		unlink(out);
		sys.FileSystem.createDirectory(out);

		#if epub
		var sectionContent = [];
		#end

		for (i in 0...sectionInfo.all.length) {
			var sec = sectionInfo.all[i];
			sec.content = generateTitleString(sec) + sec.content + "\n";
			#if !epub
			sec.content += "\n---";
			if (i != 0) sec.content += '\n\nPrevious section: ${link(sectionInfo.all[i - 1])}';
			if (i != sectionInfo.all.length - 1) sec.content += '\n\nNext section: ${link(sectionInfo.all[i + 1])}';
			sys.io.File.saveContent('$out/${url(sec)}', sec.content);
			#else
			sectionContent.push(sec.content);
			#end
		}
		generateDictionary();
		generateTodo();

		function prepare(sec:Section) {
			Reflect.deleteField(sec, "content");
			Reflect.deleteField(sec, "parent");
			sec.sub.iter(prepare);
		}
		sections.iter(prepare);
		sys.io.File.saveContent('$out/sections.txt', haxe.Json.stringify(sections));

		#if epub
		var filePath = '$out/content.md';
		sys.io.File.saveContent(filePath, sectionContent.join("\n"));
		generateEPub(filePath);
		#end

		#if mobi
			#if !epub
			#error "Generating .mobi requires -D epub to be defined"
			#end
			Sys.command("ebook-convert", ["HaxeManual.epub", "HaxeManual.mobi", "--no-inline-toc"]);
		#end
	}

	function parse(source:String) {
		LatexLexer.customEnvironments["flowchart"] = FlowchartHandler.handle;
		var input = byte.ByteData.ofString(sys.io.File.getContent(source));
		parser = new LatexParser(input, source, config);
		var sections = hxparse.Utils.catchErrors(input, parser.parse);
		return sections;
	}

	function makeSubToc(sec:Section) {
		return sec.sub.map(function(sec) return (sec.id.length > 0 ? sec.id + ": " : "") +link(sec)).join("\n\n");
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
			for (sub in sec.sub) {
				if (sec.flags.exists("fold")) {
					sub.flags["folded"] = "true";
				}
				add(sub);
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
		var entries = parser.definitions;
		entries.sort(function(v1, v2) return Reflect.compare(v1.title.toLowerCase(), v2.title.toLowerCase()));
		var definitions = [];
		for (entry in entries) {
			var anchorName = #if epub "dictionary.md-" +entry.label #else entry.label #end;
			definitions.push('<a id="$anchorName" class="anch"></a>\n\n##### ${entry.title}\n${process(entry.content)}');
		}
		sys.io.File.saveContent('$out/dictionary.md', definitions.join("\n\n"));
	}

	function generateTodo() {
		var todo = "This file is generated, do not edit!\n\n"
			+ "Todo:\n" + parser.todos.join("\n") + "\n\n"
			+ "Missing Content:\n" + sectionInfo.noContent.map(function(sec) return '${sec.id} - ${sec.title}').join("\n") + "\n\n"
			+ "Unreviewed:\n" + sectionInfo.unreviewed.join("\n") + "\n\n"
			+ "Modified:\n" + sectionInfo.modified.join("\n");
		sys.io.File.saveContent('todo.txt', todo);
	}

	function generateEPub(filePath:String) {
		Sys.command("pandoc", ["-t", "epub", "-f", "markdown_github", "-o", '$out/out.epub', "--table-of-contents", "--epub-metadata=epub_metadata.xml", filePath].concat(['$out/dictionary.md']));
	}

	function isLinkable(sec:Section) {
		return !sectionInfo.noContent.has(sec);
	}

	function link(sec:Section) {
		if (!isLinkable(sec)) {
			return #if epub '${sec.title}' #else '[${sec.title}](#)' #end;
		}
		return '[${sec.title}](${linkPrefix}${url(sec)})';
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
					#if epub
					'dictionary.md-${escapeAnchor(label.name)}';
					#else
					'dictionary.md#${escapeAnchor(label.name)}';
					#end
				case Item(i): "" + i;
				#if epub
				case Paragraph(sec, name): '${url(sec)}';
				#else
				case Paragraph(sec, name): '${url(sec)}#${escapeAnchor(name)}'; // TODO for epub
				#end
			}
		}
		function labelLink(label:Label) {
			return switch(label.kind) {
				case Section(sec): link(sec);
				case Definition: '[${label.name}](${labelUrl(label)})';
				case Item(i): "" + i;
				#if epub
				case Paragraph(sec, name): '[$name](#${url(sec)})';
				#else
				case Paragraph(sec, name): '[$name](${url(sec)}#${escapeAnchor(name)})'; // TODO for epub
				#end
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
		return s.toLowerCase().replace(" ", "-").replace(".", "");
	}

	static function url(sec:Section) {
		if (sec.flags["folded"] == "true") {
			// TODO: nested folding?
			return url(sec.parent) + "#" + escapeAnchor((sec.id.length > 0 ? sec.id + " " : "") + sec.title);
		}
		return sec.label #if !epub + ".md" #end;
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
