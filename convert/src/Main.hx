import LatexParser;

using StringTools;

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
			return ~/##([^#]+)##/g.map(s, function(r) {
				var i = r.matched(1);
				if (!parser.labelMap.exists(i)) {
					trace('Warning: No such label $i');
					return i;
				}
				return '[[manual/${escapeFileName(parser.labelMap[i].title)}]]';
			});
		}
		sys.FileSystem.createDirectory(out);
		function write(sec:Section, ?parentTitle:String) {
			var title = escapeFileName(sec.title);
			for (sub in sec.sub) {
				write(sub, title);
			}
			var content = process(sec.content.trim());
			if (content.length == 0) return;
			sys.io.File.saveContent('$out/${parentTitle == null ? "" : parentTitle + "_-_"}$title.md', content);
		}
		for (sec in sections) {
			write(sec);
		}
	}
}