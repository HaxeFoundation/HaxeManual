package;

import sys.FileSystem;
import sys.io.File;
using StringTools;

@:enum
abstract Target(String) from String to String
{
	var Swf = "swf";
	var Js = "js";
	var Neko= "neko";
	var Cpp = "cpp";
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
}

class RunTravis
{
	/** Examples that are expected to fail / *should* produce a compiler error. */
	static var requiredFailures = [
		"AbstractExposeTypeOperations.hx",
		"DynamicInferenceIssue.hx",
		"ExprOf.hx",
		"Extractor5.hx",
		"GetterSetter2.hx",
		"Property4.hx",
		"SelectiveFunction.hx",
		"Test.hx"
	];
	
	/** Examples that are not included in the tests. */
	static var excludedExamples = [
		"Color.hx",
		"ClassExpose.hx", // no main
		"FunctionTypeParameter.hx",
		"HelloPHP.hx", // PHP only
		"ImplicitTransitiveCast.hx",
		"JSRequireModule.hx",
		"JSRequireObject.hx",
		"Point.hx",
		"Point3.hx",
		"StringInterpolation.hx",
		"StructureField.hx",
		"SwitchEnum.hx",
		"SwitchStatement.hx",
		"UnitTestCase.hx",
		"UnitTestRunner.hx",
		"UnitTestSetup.hx",
		"Variance.hx",
		"Visibility.hx",
		"Visibility2.hx",
		"WhileLoop.hx"
	];
	
	/**
		Additional .hx modules needed to compile an example -
		these are not compiled themselves, but copied to /bin.
	*/
	static var additionalModules = [
		"AutoBuildingMacro.hx",
		"EnumBuildingMacro.hx",
		"MathStaticExtension.hx",
		"TypeBuildingMacro.hx"
	];
	
	static var haxelibs = [
		"HaxelibRandom.hx" => ["random"]
	];
	
	public static function main():Void {
		var target:Target = Sys.getEnv("TARGET");
		if (target == null) {
			Sys.println("No TARGET defined. Defaulting to neko.");
			target = Target.Neko;
		}
		
		excludedExamples = excludedExamples.concat(additionalModules);
		Sys.exit(getResult([
			buildExamples(target)
		]));
	}
	
	static function buildExamples(target:Target):ExitCode {
		Sys.println("\nBuilding Haxe Manual examples...\n");
		Sys.setCwd("../HaxeManual/assets");
	
		var examples = FileSystem.readDirectory(".").filter(function(f) {
			return f.endsWith(".hx") && excludedExamples.indexOf(f) == -1;
		});
	
		FileSystem.createDirectory("bin");
		for (additionalModule in additionalModules)
			File.copy(additionalModule, 'bin/$additionalModule');
	
		return getResult([for (example in examples) compile(example, target)]);
	}
	
	static function compile(file:String, target:Target):ExitCode {
		// workaround for "Module [name] does not define type [name]"
		File.copy(file, "bin/Main.hx");
	
		return runInDir("bin", function() {
			return hasExpectedResult(file, target);
		});
	}
	
	static function hasExpectedResult(file:String, target:Target):ExitCode {
		var expectedResult:ExitCode = requiredFailures.indexOf(file) == -1;
		var compileResult = Sys.command("haxe", getCompileArgs(file, target));
		
		var result:ExitCode = compileResult == expectedResult;
		if (result == ExitCode.Failure)
			Sys.stderr().writeString('Unexpected result for $file: $compileResult, expected $expectedResult\n');
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
	
	static function runInDir(dir:String, func:Void->ExitCode):ExitCode {
		var oldCwd = Sys.getCwd();
		Sys.setCwd(dir);
		var result = func();
		Sys.setCwd(oldCwd);
		return result;
	}
}