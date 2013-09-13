@:allow(Main)
class MyClass {
    static private var foo: Int;
}

class Main {
    static public function main() {
        MyClass.foo;
    }
}