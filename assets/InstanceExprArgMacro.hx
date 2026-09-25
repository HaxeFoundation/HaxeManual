import haxe.macro.Expr;
import haxe.macro.ExprTools;
import haxe.macro.MacroStringTools;

// use this for macros or other classes
class Logger {
	public final id:String;
	public function new(id:String) {
		this.id = id;
	}
	
	inline public function log(data:Any, logID:String, ?pos) {
		haxe.Log.trace('$id: $logID = [$data]', pos);
	}
	
	macro public function logExpr(instance:Expr, data:Expr):Expr {
		return eval(instance, data);
	}
	
	#if macro
	static public function eval(instance:Expr, obj:Expr):Expr {
		final id = MacroStringTools.formatString('${ExprTools.toString(obj)}', obj.pos);
		
		return macro {
			@:pos(obj.pos)
			$instance.log($obj, $id);
		};
	}
	#end
}
