class Main {
  public static function main() {
    haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos) { 
      //custom trace function here
    }
    trace("hello","warning",123);
  }
}
