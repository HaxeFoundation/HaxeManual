typedef IterableWithLength<T> = {
	> Iterable<T>,
	var length(default, null):Int; // read only property
}

class Extension {
	static public function main() {
		var array = [1, 2, 3];
		var t:IterableWithLength<Int> = array;
	}
}