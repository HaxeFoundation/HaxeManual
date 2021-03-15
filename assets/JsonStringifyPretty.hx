class Main {
	static function main() {
		var o = {rating: 5, title: "Haxe"};
		var s = haxe.Json.stringify(o, "\t");
		trace(s);
		/* {
			"rating": 5,
			"title": "Haxe"
		} */
	}
}
