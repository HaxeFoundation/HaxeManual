class Base {
	public function new() { }
	public function method() {
		return "Base";
	}
}

class Child extends Base {
	public override function method() {
		return "Child";
	}
}

class Main {
	static public function main() {
		var child:Base = new Child();
		trace(child.method()); // Child
	}
}