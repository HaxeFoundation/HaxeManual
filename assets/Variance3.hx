class Base {
  public function new() { }
}

class Child extends Base { }

typedef MyArray<T> = {
  public function pop():T;
}

class Main {
  public static function main () {
    var a = [new Child()];
    var b:MyArray<Base> = a;
  }
}