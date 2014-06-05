class Base {
  public function new() { }
}

class Child extends Base {
  private function method(obj:Child):Child {
    return obj;
  }
}

class ChildChild extends Child {
  public override function
  method(obj:Base):ChildChild {
    return null;
  }
}

class Main {
  static public function main() { }
}