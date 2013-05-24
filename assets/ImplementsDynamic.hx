class ImplementsDynamic implements Dynamic<String> {
	public var present:Int;
	public function new() {}
}

class Main {
	static public function main() {
		var c = new ImplementsDynamic();
		c.present = 1; // valid, present is an existing field
		c.stringField = "foo"; // valid, assigned value is a String
		c.intField = 1; // error, Int should be String
	}
}