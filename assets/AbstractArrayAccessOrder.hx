abstract AString(String) {
	public function new(s) this = s;
	@:arrayAccess function getInt1(k:Int) {
		return this.charAt(k);
	}
	@:arrayAccess function getInt2(k:Int) {
		return this.charAt(k).toUpperCase();
	}
}

class Main {
    static function main() {
        var a = new AString("foo");
		trace(a[0]); // f
    }
}