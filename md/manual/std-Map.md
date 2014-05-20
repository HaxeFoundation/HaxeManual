## 10.2.5 Map

A `Map` is a container composed of **key**, **value** pairs.  A `Map` is also commonly referred to as an associative array, dictionary, or symbol table.  The following code gives a short example of working with maps:

```haxe
class MapExample{
	static public function main(){
		//Maps are initialized like arrays, but use '=>' operator
		//Maps can have their key value types defined explicity
		var map1 : Map<Int, String> = [1 => "one", 2=>"two"];

		//Or they can infer their key value types
		var map2 = ["one"=>1, "two"=>2, "three"=>3];
		$type(map2); // Map<String, Int>

		//Keys must be unique
		//var map3 = [1=>"dog", 1=>"cat"]; //Error: Duplicate Key

		//Maps values can be accessed using array accessors "[]"
		var map4 = ["M"=>"Monday", "T"=>"Tuesday"];
		trace(map4["M"]); //Monday

		//Maps iterate over their values by default 
		var valueSum;
		for (value in map4)
			trace(value); //Monday \n Tuesday 

		//Can iterate over keys by using the keys() method
		for (key in map4.keys())
			trace(key);//M \n T 

        //Like arrays, a new map can be made using comprehension
        var map5 = [for (key in map4.keys()) key => "FRIDAY!!"];
        trace(map5); //{M => FRIDAY!!, T => FRIDAY!!}
	}
}
		

```

See the [http://api.haxe.org/haxe/Map.html](Map API) for details of its methods.

Under the hood, a `Map` is an [Abstract](types-abstract.md) type.  At compile time, it gets converted to one of several specialized types depending on the **key** type:


* haxe.ds.StringMap
* haxe.ds.IntMap
* haxe.ds.EnumValueMap
* haxe.ds.ObjectMap


So, at runtime, the `Map` type does not exist, and has been replaced with one of the above objects.

---

Previous section: [GenericStack](std-GenericStack.md)

Next section: [Regular Expressions](std-regex.md)