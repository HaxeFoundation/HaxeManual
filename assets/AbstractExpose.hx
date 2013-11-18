@:expose(push, pop => read)
abstract MyArray<S>(Array<S>) {
	public inline function new() {
		this = [];
	}
}

class Main {
	static public function main() {
		var myArray = new MyArray();
		myArray.push(12);
		myArray.read();
	}
}