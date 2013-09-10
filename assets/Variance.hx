class Base {
	public function new() { }
}

class Child extends Base { }

class Main {
    public static function main () {
		var children = [new Child()];
		var bases:Array<Base> = children; // Array<Child> should be Array<Base>
			// Type parameters are invariant
			// Child should be Base
    }
}