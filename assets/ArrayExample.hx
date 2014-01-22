class ArrayExample {
	static public function main() {
		//Compile error: Arrays of mixed types...
		//var myArray = [10, "Bob", false];

		//Dynamic Array with mixed types -- No Compile problems
		var myExplicitAray : Array<Dynamic> = [10, "Sally", true];

		//Initializing and iterating over an array
		var scores : Array<Int> = [110, 170, 35];
		var sum = 0;
		for (score in scores){
			sum += score;	 
		}
		trace(sum); //315

		//Growing and accessing undefined indices
		var scores : Array<Int> = [110, 170, 35];
		scores [5] = 92;
		trace(scores); //[110, 170, 35, null, null, 92]
		trace(scores[-5]); //null
	}
}

