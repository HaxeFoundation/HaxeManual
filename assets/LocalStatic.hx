class Main {
  static function getData() {
    static var cache:Null<String> = null;
    if (cache == null) {
      cache = slowOperation();
    }
    return cache;
  }

  static function slowOperation() {
    trace("performing slow operation...");
    return "result";
  }

  static public function main() {
    trace(getData()); // performing slow operation... result
    trace(getData()); // result
  }
}
