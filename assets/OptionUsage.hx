class Main {
	static public function main() {
		var result = trySomething();
		switch (result) {
			case None:
				trace("Got None");
			case Some(s):
				trace("Got something with a value: " +s);
		}
	}

	static function trySomething():haxe.ds.Option<String> {
		if (Math.random() > 0.5) {
			return None;
		} else {
			return Some("Success");
		}
	}
}