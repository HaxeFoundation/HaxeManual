class Base {
	public function new() { }
}

class Child extends Base { }

class OtherChild extends Base { }

class Main {
    public static function main () {
		var children = [new Child()];
		var bases:Array<Base> = cast children; // subvert type checker
		bases.push(new OtherChild());
		for(child in children) {
			trace(child);
		}
    }
}