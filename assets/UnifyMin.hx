class Base {
  public function new() { }
}

class Child1 extends Base { }
class Child2 extends Base { }

class UnifyMin {
  static public function main() {
    var a = [new Child1(), new Child2()];
    $type(a); // Array<Base>
  }
}