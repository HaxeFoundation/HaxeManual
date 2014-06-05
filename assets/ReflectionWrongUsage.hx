class Main {
	static function main() {
		//Reflect.callMethod(Main, "f", []); // wrong
		Reflect.callMethod(Main, Reflect.field(Main, "f"), []); // right
	}

	static function f() {
		trace('Called');
	}
}