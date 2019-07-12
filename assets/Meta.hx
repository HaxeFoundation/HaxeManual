import haxe.rtti.Meta;

@author("Nicolas")
@:keep
class MyClass {
  @range(1, 8)
  var value:Int;

  @broken
  static function method() {}
}

class Main {
  static public function main() {
    // { author : ["Nicolas"] }
    trace(Meta.getType(MyClass));
    // [1,8]
    trace(Meta.getFields(MyClass).value.range);
    // { broken: null }
    trace(Meta.getStatics(MyClass).method);
  }
}
