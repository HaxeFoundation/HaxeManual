extern class A {
  public function new();
  @:native("final") var final_:Int;
}

class Main {
  public static function main():Void {
    var a = new A();
    a.final_ = 3;
  }
}
