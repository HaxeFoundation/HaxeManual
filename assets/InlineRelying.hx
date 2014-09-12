class Main {
    public static function main () { }

	static function test() {
		if (Math.random() > 0.5) {
			return "ok";
		} else {
			error("random failed");
		}
	}

	static inline function error(s:String) {
		throw s;
	}
}