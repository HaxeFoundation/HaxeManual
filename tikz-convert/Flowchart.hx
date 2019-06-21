import haxe.io.Path;
import haxe.Resource;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class Flowchart {
	public static function main():Void {
		switch (Sys.args()) {
			case [inputPath, targetPath]:
				handle(inputPath, targetPath);
			case _:
				Sys.println("usage: neko flowchart.n <input.tex> <output.png>");
		}
	}

	public static function handle(inputPath:String, targetPath:String):Void {
		var content = File.getContent(inputPath);
		var template = File.getContent("envTemplate.tex");

		var originalCwd = Sys.getCwd();
		var tempDir = "latextemp";
		if (!FileSystem.exists(tempDir)) FileSystem.createDirectory(tempDir);
		Sys.setCwd(tempDir);

		File.saveContent("temp.tex", template.replace("%%%CONTENT%%%", content));

		//Sys.command("pdflatex", ["-interaction=nonstopmode", "temp.tex"]);
		if (Sys.command("xelatex", ["-interaction=nonstopmode", "temp.tex"]) != 0)
			throw "xelatex failed";
		//if (Sys.command("convert", ["-density", "120", "temp.pdf", "temp.png"]) != 0)
		if (Sys.command("mudraw", ["-r", "110", "-c", "rgba", "-o", 'temp.png', 'temp.pdf']) != 0)
			throw "mudraw failed";

		Sys.setCwd(originalCwd);

		File.copy('$tempDir/temp.png', targetPath);
	}
}