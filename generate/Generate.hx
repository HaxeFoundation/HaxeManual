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
	// TODO: change back to the haxe repo once #8350 is merged
	static final GITHUB_RAW_URL = "https://raw.githubusercontent.com/Aurel300/haxe/feature/manual-references";
	//static final GITHUB_RAW_URL = "https://raw.githubusercontent.com/HaxeFoundation/haxe/development";
	static final MANUAL_URL = "https://haxe.org/manual/";
	static final OUTPUT_DIR = "../output-md/generated";

	static function get(url:String):String {
		Sys.println('GET $url ...');
		var proc = new Process("curl", [url]);
		var data = proc.stdout.readAll().toString();
		proc.close();
		return data;
	}

	static function generateFile<T:EntryCommon>(
		filename:String,
		source:Array<T>,
		formatName:(entry:T)->String
	):Void {
		Sys.println('generating ${filename} ...');
		var outputFile = File.write('${OUTPUT_DIR}/${filename}.md');
		var w = outputFile.writeString;
		for (entry in source) {
			// Name
			w(formatName(entry));
			// Parameters
			w(" | ");
			if (entry.params != null && entry.params.length > 0)
				w("&lt;" + entry.params.join(">, &lt;") + ">");
			// Description
			w(' | ${entry.doc}');
			var manualLinks = entry.links != null ? entry.links.filter(link -> link.startsWith(MANUAL_URL)) : [];
			if (manualLinks.length > 0) {
				w(' See ');
				w([ for (ref in manualLinks) {
					var id = ref.split("/").pop().split(".")[0];
					'[$id]($id)';
				} ].join(", "));
				w('.');
			}
			// Platforms
			w(' | ');
			if (entry.platforms != null && entry.platforms.length > 0)
				w(entry.platforms.join(", "));
			else
				w("all");
			w("\n");
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
				define -> '`${define.define}`'
			);

		// generate metas.tex
		generateFile(
				"metas",
				metas.filter(meta -> !meta.internal),
				meta -> '`@${meta.metadata}`'
			);
	}
}
