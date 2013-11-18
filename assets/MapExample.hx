class MapExample{
	static public function main(){
		//Maps are initialized similar to arrays, but use the '=>' operator
		//Maps can have their key value types defined explicity
		var map1 : Map<Int, String> = [1 => "one", 2=>"two"];

		//Or they can infer their key value types
		var map2 = ["one"=>1, "two"=>2, "three"=>3];
		$type(map2); // Map<String, Int>

		//Keys must be unique
		//var map3 = [1=>"dog", 1=>"cat"]; //Error: Duplicate Key

		//Maps values can be accessed using array accessors "[]"
		var map4 = ["M"=>"Monday", "T"=>"Tuesday"];
		trace(map4["M"]);

		//Maps iterate over their values by default 
		var valueSum;
		for (value in map4)
			trace(value); //Monday \n Tuesday 

		//But can iterate over their keys by using the keys() method
		for (key in map4.keys())
			trace(key);//M \n T 

        //Like arrays, a new map can be made using comprehension
        var map5 = [for (key in map4.keys()) key => "FRIDAY!!"];
        trace(map5); //{M => FRIDAY!!, T => FRIDAY!!}
	}
}
		
