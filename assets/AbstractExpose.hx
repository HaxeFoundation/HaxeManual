@:forward(push, pop)
abstract MyArray<S>(Array<S>) {
	public inline function new() {
		this = [];
	}
}

class Main {
	static public function main() {
		var myArray = new MyArray();
		myArray.push(12);
		myArray.pop();
		//myArray.length; // MyArray<Int> has no field length
	}
}