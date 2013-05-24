class OptionalArguments {
	static public function main() {
		$type(test); // ?i : Int -> ?s : String -> String
		trace(test()); // i: null, s: null
		trace(test(1)); // i: 1, s: null
		trace(test(1, "foo")); // i: 1, s: foo
		trace(test("foo")); // i: null, s: foo
	}
	
	static function test(?i:Int, ?s:String):String {
		return "i: " +i + ", s: " +s;
	}
}