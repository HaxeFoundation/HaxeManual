@author("Nicolas")
@debug
class MyClass {
	@range(1, 8)
	var value:Int;
	
	@broken
	@:noCompletion
	static function method() { }
}

class Main {
	static public function main() {
		trace(haxe.rtti.Meta.getType(MyClass)); // { author : ["Nicolas"], debug : null }
		trace(haxe.rtti.Meta.getFields(MyClass).value.range); // [1,8]
		trace(haxe.rtti.Meta.getStatics(MyClass).method); // { broken: null }
	}
}