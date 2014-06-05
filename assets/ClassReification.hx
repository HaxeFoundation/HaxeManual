class Main {
  macro static function
  generateClass(funcName:String) {
    var c = macro class MyClass {
      public function new() { }
      public function $funcName() {
        trace($v{funcName} + " was called");
      }
    }
    haxe.macro.Context.defineType(c);
    return macro new MyClass();
  }

    public static function main() {
    var c = generateClass("myFunc");
    c.myFunc();
    }
}