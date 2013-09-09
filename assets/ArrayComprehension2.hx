class Main {
	static public function main() {
		var a = [
			for (a in 1...11)
				for(b in 2...Std.int(a / 2) + 1)
					if (a % b == 0)
						a+ "/" +b
		];
		trace(a); // [4/2,6/2,6/3,8/2,8/4,9/3,10/2,10/5]
	}
}