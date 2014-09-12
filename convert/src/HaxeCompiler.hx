class HaxeCompiler {
	public function new(path:String) {
		var content = sys.io.File.getContent(path);
		content = ~/([^\\])"/g.replace(content, '$1\\"');
		if (content.charCodeAt(0) == "@".code) {
			content = "//\n" + content; // avoid leading @
		}
		var p = new sys.io.Process("haxe", ["--eval", content, "--interp"]);
		var err = p.stderr.readAll();
		if (p.exitCode() != 0) trace('Failed: $path\n$err');
	}
}