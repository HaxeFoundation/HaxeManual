class FunctionTypeParameter {
	static public function main() {
		equals(1, 1);
		equals("foo", "bar"); // runtime message: bar should be foo
		equals(1, "foo"); // compiler error: String should be Int
	}
	
	static function equals<T>(expected:T, actual:T) {
		if (actual != expected) trace('$actual should be $expected');
	}
}