class Test {
    function foo() {
		haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos) { 
			// custom trace function here
		}
        trace("hello","warning",123);
    }
}