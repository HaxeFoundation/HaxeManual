import haxe.io.Path;
import haxe.Resource;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

using StringTools;

class FlowchartHandler {
	
	static public function handle(s:String) {
		var envargRegexp = ~/{(.+)}{(.+)}/;
		if (!envargRegexp.match(s)) throw "Custom environment definition doesn't match expected argument template.";
		var envlabel = envargRegexp.matched(1);
		var envtitle = envargRegexp.matched(2);
		var targetPath = "assets/graphics/generated/"+envlabel+".png";
		pdflatexCompile(Resource.getString("tikzTemplate"), "\\begin{flowchart}" + s + "\\end{flowchart}", targetPath);
		var relativePath = "../../" + targetPath;
		return '![$envtitle]($relativePath)\n\n_Figure: ${envtitle}_';
	}
	
	static function pdflatexCompile(template:String, content:String, targetPath:String) {
		
		// TODO: error checking for pdflatex / convert
		
		#if !(compileEnv || recompileEnv)
		return;
		#end
		
		var cwd = Sys.getCwd();
		
		var path = Path.addTrailingSlash(new Path(cwd).dir) + targetPath;
		
		if (FileSystem.exists(path)) {
			#if recompileEnv
			FileSystem.deleteFile(path);
			#else
			trace("Target pdflatex file already exists, ignoring: " + path);
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
		
		Sys.command("pdflatex", ["-interaction=nonstopmode", Path.withoutDirectory(texFile)]);
		Sys.command("convert", ["-density", "120", tempName + ".pdf", tempName + ".png"]);
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
		
		// Cleanup
		#if !keepEnvTemp
		FileSystem.deleteFile(tempDir + tempName + ".log");
		FileSystem.deleteFile(tempDir + tempName + ".aux");
		FileSystem.deleteFile(tempDir + tempName + ".tex");
		FileSystem.deleteFile(tempDir + tempName + ".pdf");
		FileSystem.deleteDirectory(tempDir);
		#end
		
	}
}