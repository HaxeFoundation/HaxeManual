@:nullSafety
class Main {
  static function getNullableStr():Null<String> {
    return null;
  }
  
  public static function main() {
    function fn(s:String) {}
    var nullable:Null<String> = getNullableStr();
    // all of the following lines would cause a compilation error:
    //var str:String = null;
    //var str:String = nullable;
    //fn(nullable);
  }
}