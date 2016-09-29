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
		var config:Config = {
			sourceDirectory: ".",
			sourceFile: null,
			output: new haxe.io.Path("output/"),
			outputMode: Markdown,
			omitIds: false,
		}

		var handler = hxargs.Args.generate([
			@doc("Sets the input directory")
			"-i" => function(directory:String) {
				config.sourceDirectory = directory;
			},
			@doc("Sets the output")
			"-o" => function(output:String) {
				config.output = new haxe.io.Path(output);
				switch (output.split(".").pop()) {
					case "epub": config.outputMode = EPub;
					case "mobi": config.outputMode = Mobi;
				}
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
		out = config.output.dir;

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
			var s = '$prefix ${sec.id.length > 0 ? sec.id + " " : ""}${sec.title}\n\n';
			return switch (config.outputMode) {
				case EPub | Mobi:
					'<a id="${url(sec)}"></a>\n' + s;
				case Markdown:
					s;
			}
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

		var sectionContent = [];

		for (i in 0...sectionInfo.all.length) {
			var sec = sectionInfo.all[i];
			sec.content = generateTitleString(sec) + sec.content + "\n";
			if (config.outputMode == Markdown) {
			sec.content += "\n---";
			if (i != 0) sec.content += '\n\nPrevious section: ${link(sectionInfo.all[i - 1])}';
			if (i != sectionInfo.all.length - 1) sec.content += '\n\nNext section: ${link(sectionInfo.all[i + 1])}';
			sys.io.File.saveContent('$out/${url(sec)}', sec.content);
			} else {
				sectionContent.push(sec.content);
			}
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

		switch (config.outputMode) {
			case EPub | Mobi:
				var filePath = '$out/content.md';
				sys.io.File.saveContent(filePath, sectionContent.join("\n"));
				generateEPub(filePath);
			case Markdown:
		}

		switch (config.outputMode) {
			case Mobi:
				if (Sys.command("ebook-convert", ['$out/${config.output.file}.epub', '$out/${config.output.file}.mobi', "--no-inline-toc"]) != 0)
					throw "ebook-convert failed";
			case _:
		}
	}

	function parse(source:String) {
		LatexLexer.customEnvironments["flowchart"] = FlowchartHandler.handle.bind(config);
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
			var anchorName = switch (config.outputMode) {
				case Markdown: entry.label;
				case EPub | Mobi: "dictionary.md-" +entry.label;
			}
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
		if (Sys.command("pandoc", ["-t", "epub", "-f", "markdown_github", "-o", '$out/${config.output.file}.epub', "--table-of-contents", "--epub-metadata=epub_metadata.xml", filePath].concat(['$out/dictionary.md'])) != 0)
			throw "pandoc failed";
	}

	function isLinkable(sec:Section) {
		return !sectionInfo.noContent.has(sec);
	}

	function link(sec:Section) {
		if (!isLinkable(sec)) {
			return switch (config.outputMode) {
				case EPub | Mobi: '${sec.title}';
				case Markdown: '[${sec.title}](#)';
			}
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
				case Definition if (config.outputMode == Markdown):
					'dictionary.md#${escapeAnchor(label.name)}';
				case Definition:
					'dictionary.md-${escapeAnchor(label.name)}';
				case Item(i): "" + i;
				case Paragraph(sec, name) if (config.outputMode == Markdown): '${url(sec)}#${escapeAnchor(name)}';
				case Paragraph(sec, name): '${url(sec)}';
			}
		}
		function labelLink(label:Label) {
			return switch(label.kind) {
				case Section(sec): link(sec);
				case Definition: '[${label.name}](${labelUrl(label)})';
				case Item(i): "" + i;
				case Paragraph(sec, name) if (config.outputMode == Markdown):
					'[$name](${url(sec)}#${escapeAnchor(name)})';
				case Paragraph(sec, name): '[$name](#${url(sec)})';
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
		if (sec.flags["folded"] == "true") {
			// TODO: nested folding?
			return url(sec.parent) + "#" + escapeAnchor((sec.id.length > 0 ? sec.id + " " : "") + sec.title);
		}
		return switch (config.outputMode) {
			case EPub | Mobi: sec.label;
			case Markdown: sec.label + ".md";
		}
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
