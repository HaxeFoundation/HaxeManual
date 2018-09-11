import haxe.io.Path;
import haxe.Resource;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class FlowchartHandler {

	static public function handle(config:Config, s:String) {
		var envargRegexp = ~/{(.+)}{(.+)}/;
		if (!envargRegexp.match(s)) throw "Custom environment definition doesn't match expected argument template.";
		var envlabel = envargRegexp.matched(1);
		var envtitle = envargRegexp.matched(2);
		var targetPath = "assets/graphics/generated/";
		var targetName = envlabel;
		latexCompile(Resource.getString("tikzTemplate"), "\\begin{flowchart}" + s + "\\end{flowchart}", targetPath, targetName);
		var filePath = targetPath + targetName + ".png";
		var relativePath = "../../../HaxeManual/" + filePath;
		switch (config.outputMode) {
			case EPub | Mobi:
				return '![$envtitle]($filePath)';
			case Markdown:
				return '<img src="$relativePath" alt="$envtitle" title="$envtitle" />\n\n_Figure: ${envtitle}_';
		}
	}

	static function latexCompile(template:String, content:String, targetPath:String, targetName:String) {
		// TODO: error checking for latex / mudraw
		#if !(compileEnv || recompileEnv)
		return;
		#end
		var cwd = Sys.getCwd();
		var path = Path.addTrailingSlash(new Path(cwd).dir) + targetPath + targetName + ".png";

		if (FileSystem.exists(path)) {
			#if recompileEnv
			FileSystem.deleteFile(path);
			#else
			trace("Target file already exists, ignoring: " + path);
			return;
			#end
		}

		var tempDir = new Path(cwd + "latextemp/").dir;

		#if !keepEnvTemp
		if (FileSystem.exists(tempDir)) {
			throw 'Temporary latex compilation directory already exists: $tempDir';
		}
		#end

		FileSystem.createDirectory(tempDir);

		Sys.setCwd(tempDir);
		tempDir = Path.addTrailingSlash(tempDir);
		var tempName = "temp";
		var texFile = tempDir + tempName + ".tex";

		#if !keepEnvTemp
		if (FileSystem.exists(texFile)) {
			throw 'Temporary latex file already exists: $texFile';
		}
		#end

		var replaced = template.replace("%%%CONTENT%%%", content);
		var fout = File.write(texFile);
		fout.writeString(replaced);
		fout.close();
		//Sys.command("pdflatex", ["-interaction=nonstopmode", Path.withoutDirectory(texFile)]);
		//Sys.command("convert", ["-density", "120", tempName + ".pdf", tempName + ".png"]);
		if (Sys.command("xelatex", ["-interaction=nonstopmode", Path.withoutDirectory(texFile)]) != 0)
			throw "xelatex failed";
		if (Sys.command("mudraw", ["-r", "110", "-c", "rgba", "-o", tempName + ".png", tempName + ".pdf"]) != 0)
			throw "mudraw failed";
		Sys.setCwd(cwd);

		var imagePath = tempDir + tempName + ".png";
		if (!FileSystem.exists(imagePath)) {
			throw "Supposedly generated image at " + imagePath + " not found.";
		}

		try {
			FileSystem.rename(imagePath, path);
		} catch (e:String) {
			throw 'Unable to move image from $imagePath to $path. Make sure the target directory exists.';
		}
		#if keepEnvPDF
		var pdfSourcePath = tempDir + tempName + ".pdf";
		var pdfTargetpath = Path.addTrailingSlash(new Path(cwd).dir) + targetPath + targetName + ".pdf";
		if (!FileSystem.exists(pdfSourcePath)) {
			throw "Supposedly generated pdf at " + pdfSourcePath + " not found.";
		}

		try {
			if (FileSystem.exists(pdfTargetpath)) FileSystem.deleteFile(pdfTargetpath);
			FileSystem.rename(pdfSourcePath, pdfTargetpath);
		} catch (e:String) {
			throw 'Unable to move pdf from $pdfSourcePath to $pdfTargetpath. Make sure the target directory exists.';
		}
		#end
		// Cleanup
		#if !keepEnvTemp
		FileSystem.deleteFile(tempDir + tempName + ".log");
		FileSystem.deleteFile(tempDir + tempName + ".aux");
		FileSystem.deleteFile(tempDir + tempName + ".tex");
		#if !keepEnvPDF
		FileSystem.deleteFile(tempDir + tempName + ".pdf");
		#end
		FileSystem.deleteDirectory(tempDir);
		#end

	}
}