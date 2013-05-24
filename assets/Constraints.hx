typedef Measurable = {
	public var length(default, null):Int;
}

class Constraints {	
	static public function main() {
		trace(test([]));
		trace(test(["bar", "foo"]));
		test("foo"); // String should be Iterable<String>
	}
	
	static function test<T:(Iterable<String>, Measurable)>(a:T) {
		if (a.length == 0) return "empty";
		return a.iterator().next();
	}
}