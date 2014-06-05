import haxe.macro.Context;
import haxe.macro.Expr;

#if !macro
@:autoBuild(MyMacro.build())
#end
interface I1 { }

#if !macro
@:autoBuild(MyMacro.build())
#end
interface I2 { }

class C implements I1 implements I2 { }

class MyMacro {
  macro static public function
  build():Array<Field> {
    var c = Context.getLocalClass().get();
    if (c.meta.has(":processed")) return null;
    c.meta.add(":processed",[],c.pos);
    // process here
    return null;
  }
}

class Main {
  static public function main() { }
}