abstract Abstract(Int) {
	inline public function new(i:Int) {
		this = i;
	}
}

class MyAbstract {
	static public function main() {
		var a = new Abstract(12);
		trace(a);
	}
}