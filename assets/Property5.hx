class Base {
	public function get_x() return 1;
}

class Main extends Base {
	public var x(get, null):Int; // ok, get_x is declared by parent class
	
	static public function main() {}
}