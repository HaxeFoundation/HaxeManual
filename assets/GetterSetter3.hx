class Main {
	@:isVar public var x(get, set):Int;
	
	function get_x() {
		return x;
	}
	
	function set_x(x) {
		return this.x = x;
	}
	
	static public function main() {}
}