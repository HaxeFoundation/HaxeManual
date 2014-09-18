using StringTools;

typedef HaxeResult = {
	success: Bool,
	exitCode: Int,
	stdout: String,
	stderr: String
}

class HaxeCompiler {
	static public function parse(content:haxe.io.Bytes, ?args:Array<String>) {
		if (args == null) {
			args = [];
		}
		var p = new sys.io.Process("haxe", ["--eval", "stdin", "--interp"].concat(args));
		p.stdin.write(content);
		p.stdin.flush();
		p.stdin.close();
		var err = p.stderr.readAll();
		var out = p.stdout.readAll();
		var code = p.exitCode();
		return {
			success: code == 0,
			exitCode: code,
			stdout: out.toString().trim(),
			stderr: err.toString().trim()
		}
	}
}