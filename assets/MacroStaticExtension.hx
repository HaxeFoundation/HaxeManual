import haxe.macro.Context;
import haxe.macro.Expr;

using Main;
using haxe.macro.Tools;

class Main {
	static public function main() {
		"foo".test();
	}
	
	macro static function test(e:ExprOf<String>) {
		trace(e.toString()); // @:this this
		trace(Context.typeof(e)); // TInst(String,[])
		return e;
	}
}