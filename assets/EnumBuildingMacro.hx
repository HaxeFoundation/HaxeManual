import haxe.macro.Context;
import haxe.macro.Expr;

class EnumBuildingMacro {
	macro static public function build():Array<Field> {
		var noArgs = makeEnumField("A", FVar(null, null));
		var fInt = switch (macro function(value:Int) { }).expr {
			case EFunction(_,f): f;
			case _: throw "false";
		}
		var intArg = makeEnumField("B", FFun(fInt));
		return [noArgs, intArg];
	}
	
	static function makeEnumField(name, kind) {
		return {
			name: name,
			doc: null,
			meta: [],
			access: [],
			kind: kind,
			pos: Context.currentPos()
		}
	}
}