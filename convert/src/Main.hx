import LatexParser;

using StringTools;
using Lambda;

class Main{
	static function main() {
		Sys.setCwd("../");
		var input = byte.ByteData.ofString(sys.io.File.getContent("HaxeDoc.tex"));
		var parser = new LatexParser(input, "HaxeDoc.tex");
		var sections = parser.parse();
		var out = "md/manual";
		var linkBase = "https://github.com/Simn/HaxeManual/tree/master/";
		function escapeFileName(s:String) {
			return s.replace("?", "").replace("/", "_").replace(" ", "_");
		}
		function url(sec:Section) {
			return sec.id + "-" +(escapeFileName(sec.title)) + ".md";
		}
		function process(s:String):String {
			return ~/~~~([^~]+)~~~/g.map(s, function(r) {
				var i = r.matched(1);
				if (!parser.labelMap.exists(i)) {
					trace('Warning: No such label $i');
					return i;
				}
				var sec = parser.labelMap[i];
				return '[${sec.title}]($linkBase$out/${url(sec)})';
			});
		}
		sys.FileSystem.createDirectory(out);
		function write(sec:Section) {
			for (sub in sec.sub) {
				write(sub);
			}
			var content = process(sec.content.trim());
			if (content.length == 0) return;
			content = '## ${sec.id} ${sec.title}\n\n' + content;
			sys.io.File.saveContent('$out/${url(sec)}', content);
		}
		for (sec in sections) {
			write(sec);
		}
		
		var a = [for (k in parser.definitionMap.keys()) {k:k, v:parser.definitionMap[k]}];
		a.sort(function(v1, v2) return Reflect.compare(v1.k.toLowerCase(), v2.k.toLowerCase()));
		sys.io.File.saveContent('$out/dictionary.md', a.map(function(v) return '##### ${v.k}\n${process(v.v)}').join("\n\n"));
	}
}