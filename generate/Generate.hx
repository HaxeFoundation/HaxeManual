import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

using StringTools;

typedef EntryCommon = {
		doc:String,
		?platforms:Array<String>,
		?params:Array<String>,
		?links:Array<String>
	};

typedef Define = EntryCommon & {
		name:String,
		define:String,
		?devcomment:String
	};

typedef Meta = EntryCommon & {
		name:String,
		metadata:String,
		?devcomment:String,
		?internal:Bool,
		?targets:Array<String>
	};

class Generate {
	static final GITHUB_RAW_URL = "https://raw.githubusercontent.com/HaxeFoundation/haxe/development";
	static final MANUAL_URL = "https://haxe.org/manual/";
	static final OUTPUT_DIR = "../HaxeManual/generated";
	static final OUTPUT_HEADER = "% This file was automatically generated using Generate.hx\n"
		+ '% at ${Date.now().toString()}\n'
		+ "% Do not edit manually\n\n";

	static function get(url:String):String {
		Sys.println('GET $url ...');
		var proc = new Process("curl", [url]);
		var data = proc.stdout.readAll().toString();
		proc.close();
		return data;
	}

	static function latexify(doc:String):String {
		doc = doc.replace("\\", "\\textbackslash{}");
		doc = doc.replace("C#", "C\\#");
		// hacky because no \b support
		doc = ~/([ \t\n\(])`([^`]*)`([ \t\n\)\.,;])/g.map(doc, e -> '${e.matched(1)}\\ic{${e.matched(2)}}${e.matched(3)}');
		doc = ~/([ \t\n\(])'([^']*)'([ \t\n\)\.,;])/g.map(doc, e -> '${e.matched(1)}`${e.matched(2)}\'${e.matched(3)}');
		doc = ~/([ \t\n\(])"([^"]*)"([ \t\n\)\.,;])/g.map(doc, e -> '${e.matched(1)}``${e.matched(2)}\'\'${e.matched(3)}');
		return doc;
	}

	static function generateFile<T:EntryCommon>(
		filename:String,
		source:Array<T>,
		formatName:(entry:T)->String
	):Void {
		Sys.println('generating ${filename} ...');
		var outputFile = File.write('${OUTPUT_DIR}/${filename}.tex');
		var w = outputFile.writeString;
		w(OUTPUT_HEADER);
		for (entry in source) {
			// Name
			w('\t${formatName(entry)}');
			// Parameters
			w(" & ");
			if (entry.params != null && entry.params.length > 0)
				w("\\textless{}" + entry.params.map(param -> param.replace("|", "\\textbar{}")).join("\\textgreater{}, \\textless{}") + "\\textgreater{}");
			// Description
			w(' & ${latexify(entry.doc)}');
			var manualLinks = entry.links != null ? entry.links.filter(link -> link.startsWith(MANUAL_URL)) : [];
			if (manualLinks.length > 0) {
				w(' See ');
				w([ for (ref in manualLinks) '\\Fullref{${ref.split("/").pop().split(".").shift()}}' ].join(", "));
				w('.');
			}
			// Platforms
			w(' & ');
			if (entry.platforms != null && entry.platforms.length > 0)
				w(entry.platforms.join(", "));
			else
				w("all");
			w(" \\\\\n");
		}
		outputFile.close();
	}

	static function main():Void {
		// checkout files and JSON parse
		var defines:Array<Define> = Json.parse(get('${GITHUB_RAW_URL}/src-json/define.json'));
		var metas:Array<Meta> = Json.parse(get('${GITHUB_RAW_URL}/src-json/meta.json'));

		if (!FileSystem.exists(OUTPUT_DIR))
			FileSystem.createDirectory(OUTPUT_DIR);

		// generate defines.tex
		generateFile(
				"defines",
				defines,
				define -> '\\expr{${define.define}}'
			);

		// generate metas.tex
		generateFile(
				"metas",
				metas.filter(meta -> !meta.internal),
				meta -> '\\expr{@${meta.metadata}}'
			);
	}
}
