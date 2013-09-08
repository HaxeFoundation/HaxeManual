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
		function escapeFileName(s:String) {
			return s.replace("?", "").replace("/", "_").replace(" ", "_");
		}
		function process(s:String):String {
			return ~/~~~([^~]+)~~~/g.map(s, function(r) {
				var i = r.matched(1);
				if (!parser.labelMap.exists(i)) {
					trace('Warning: No such label $i');
					return i;
				}
				return '[manual/${escapeFileName(parser.labelMap[i].title)}]';
			});
		}
		sys.FileSystem.createDirectory(out);
		function write(sec:Section, ?parentIndex:String) {
			var index = (parentIndex == null ? "" : parentIndex + ".") + (sec.index + 1);
			var title = index + "-" + escapeFileName(sec.title);
			for (sub in sec.sub) {
				write(sub, index);
			}
			var content = process(sec.content.trim());
			if (content.length == 0) return;
			content = '## $index ${sec.title}\n\n' + content;
			sys.io.File.saveContent('$out/$title.md', content);
		}
		for (sec in sections) {
			write(sec);
		}
		
		var a = [for (k in parser.definitionMap.keys()) {k:k, v:parser.definitionMap[k]}];
		a.sort(function(v1, v2) return Reflect.compare(v1.k.toLowerCase(), v2.k.toLowerCase()));
		sys.io.File.saveContent('$out/dictionary.md', a.map(function(v) return '##### ${v.k}\n${process(v.v)}').join("\n\n"));
	}
}