## 10.2.6 Option

An option is an [enum](types-enum-instance.md) in the Haxe Standard Library which is defined like so:

```haxe
enum Option<T> {
	Some(v:T);
	None;
}
```

It can be used in various situations, such as communicating whether or not a method had a valid return and if so, what value it returned:

```haxe
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
```

---

Previous section: [Map](std-Map.md)

Next section: [Regular Expressions](std-regex.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/10-std.tex#L122-122)