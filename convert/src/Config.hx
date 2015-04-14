enum OutputMode {
	Markdown;
	EPub;
	Mobi;
}

typedef Config = {
	sourceDirectory: String,
	sourceFile: Null<String>,
	output: haxe.io.Path,
	outputMode: OutputMode,
	omitIds: Bool
}