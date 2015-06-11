package;

import sys.FileSystem;
import sys.io.File;
using StringTools;

@:enum
abstract Target(String) from String to String
{
	var Swf = "swf";
	var As3 = "as3";
	var Js = "js";
	var Neko = "neko";
	var Cpp = "cpp";
	var Cs = "cs";
	var Java = "java";
	var Python = "python";
}

@:enum
abstract ExitCode(Int) from Int to Int
{
	var Success = 0;
	var Failure = 1;

	@:from
	static function fromBool(b:Bool):ExitCode {
		return b ? ExitCode.Success : ExitCode.Failure;
	}

	@:to
	function toColor():Color {
		return (this == ExitCode.Success) ? Color.Green : Color.Red;
	}
}

@:enum
abstract Color(Int)
{
	var None = 0;
	var Red = 31;
	var Green = 32;
}

enum InsertIn
{
	Function;
	Module;
}

class RunTravis
{
	/** Examples that are expected to fail / *should* produce a compiler error. */
	static var requiredFailures = [
		"AbstractExposeTypeOperations.hx",
		"DynamicInferenceIssue.hx",
		"ExprOf.hx",
		"Extractor5.hx",
		"FunctionTypeParameter.hx",
		"GetterSetter2.hx",
		"ImplicitTransitiveCast.hx",
		"Property4.hx",
		"SelectiveFunction.hx",
		"SwitchEnum.hx",
		"Test.hx",
		"Variance.hx",
		"Visibility.hx",
		"Visibility2.hx"
	];

	/** Examples that are not included in the tests. */
	static var excludedExamples = {
		var a = [
			"ClassExpose.hx", // no main()
			"HelloPHP.hx", // PHP only
			"JSRequireModule.hx",
			"JSRequireObject.hx",
			"RestAndEitherType.hx", // requires an extern
			"SwitchStatement.hx", // pseudo-code
			"UnitTestCase.hx",
			"UnitTestRunner.hx",
			"UnitTestSetup.hx"
		];
		if (Sys.getEnv("TRAVIS") == "true" && Sys.getEnv("TRAVIS_HAXE_VERSION") == "3.2.0") {
			a.push("SafeCast.hx"); // https://github.com/HaxeFoundation/haxe/issues/4310
			a.push("Import.hx"); // problem with StringMap on Haxe/C++
		}
		a;
	}

	/** Additional .hx modules needed to compile specific examples. */
	static var additionalModules = [
		"AutoBuilding.hx" => "AutoBuildingMacro.hx",
		"EnumBuilding.hx" => "EnumBuildingMacro.hx",
		"GenericBuild1.hx" => "GenericBuildMacro1.hx",
		"GenericBuild2.hx" => "GenericBuildMacro2.hx",
		"Point3.hx" => "Point.hx",
		"MathExtensionUsage.hx" => "MathStaticExtension.hx",
		"TypeBuilding.hx" => "TypeBuildingMacro.hx"
	];
	
	/** Snippets that don't compile on their own */
	static var incompleteSnippets = [
		"Color.hx" => Module,
		"Point.hx" => Module,
		"Point3.hx" => Module,
		"StringInterpolation.hx" => Function,
		"StructureField.hx" => Module,
		"WhileLoop.hx" => Function
	];

	static var haxelibs = [
		"HaxelibRandom.hx" => ["random"]
	];
	
	static var helperFile:String;

	public static function main():Void {
		var target:Target = Sys.args()[0];
		if (target == null) {
			Sys.println("No TARGET defined. Defaulting to neko.");
			target = Target.Neko;
		}

		for (additionalModule in additionalModules)
			excludedExamples.push(additionalModule);
		// special case, both needed as an additional module and needs to compile on its own
		excludedExamples.remove("Point.hx");
	
		helperFile = File.getContent("Helper.hx");
	
		Sys.exit(getResult([
			buildExamples(target, Sys.args().slice(1))
		]));
	}

	static function buildExamples(target:Target, ?included:Array<String>):ExitCode {
		Sys.println("\nBuilding Haxe Manual examples...\n");
		Sys.setCwd("../HaxeManual/assets");

		var examples = FileSystem.readDirectory(".").filter(function(f) {
			return f.endsWith(".hx") && excludedExamples.indexOf(f) == -1;
		}).filter(function(f) {
			return included.length == 0 || included.indexOf(f) != -1;
		});

		FileSystem.createDirectory("bin");
		for (additionalModule in additionalModules)
			File.copy(additionalModule, 'bin/$additionalModule');

		var results = [for (example in examples) compile(example, target)];
		var successCount = results.filter(function(e) return e == ExitCode.Success).length;
		var totalCount = examples.length;
		var exitCode:ExitCode = !(successCount < totalCount);
		Sys.println("");
		printWithColor([for (i in 0...50) "-"].join(""), exitCode);
		printWithColor('$successCount/$totalCount examples built successfully.', exitCode);

		return exitCode;
	}

	static function compile(file:String, target:Target):ExitCode {
		var dir = "bin/" + getFileName(file);
		FileSystem.createDirectory(dir);
		
		var insertIn = incompleteSnippets.get(file);
		if (insertIn != null) {
			var fileOutput = File.write('$dir/Main.hx');
			var fileContent = File.getContent(file);
			
			fileOutput.writeString(helperFile
				.replace("<module>", (insertIn == Module) ? fileContent : "")
				.replace("<function>", (insertIn == Function) ? fileContent : ""));
			fileOutput.close();
		} else {
			// workaround for "Module [name] does not define type [name]"
			File.copy(file, '$dir/Main.hx');
		}

		var additional = additionalModules.get(file);
		if (additional != null)
			File.copy(additional, '$dir/$additional');

		return runInDir(dir, function() {
			return hasExpectedResult(file, target);
		});
	}

	static function hasExpectedResult(file:String, target:Target):ExitCode {
		var expectedResult:ExitCode = requiredFailures.indexOf(file) == -1;
		var compileResult = Sys.command("haxe", getCompileArgs(file, target));

		var result:ExitCode = compileResult == expectedResult;
		if (result == ExitCode.Failure)
			printWithColor('Unexpected result for $file:' +
				'$compileResult, expected $expectedResult', Color.Red);
		return result;
	}

	static function getCompileArgs(file:String, target:Target):Array<String> {
		var compileArgs = ["-main", "Main", '-$target', target];
		var haxelibs = haxelibs[file];
		if (haxelibs != null) {
			for (haxelib in haxelibs) {
				compileArgs.push("-lib");
				compileArgs.push(haxelib);
			}
		}
		return compileArgs;
	}

	static function getResult(results:Array<ExitCode>):ExitCode {
		for (result in results)
			if (result != ExitCode.Success)
			return ExitCode.Failure;
		return ExitCode.Success;
	}

	static function printWithColor(message:String, color:Color):Void {
		setColor(color);
		Sys.println(message);
		setColor(Color.None);
	}

	static function setColor(color:Color):Void {
		if (Sys.systemName() == "Linux") {
			var id = (color == Color.None) ? "" : ';$color';
			Sys.stderr().writeString("\033[0" + id + "m");
		}
	}

	static function runInDir(dir:String, func:Void->ExitCode):ExitCode {
		var oldCwd = Sys.getCwd();
		Sys.setCwd(dir);
		var result = func();
		Sys.setCwd(oldCwd);
		return result;
	}

	static function getFileName(file:String):String {
		var dotIndex = file.lastIndexOf(".");
		return file.substring(0, dotIndex);
	}
}