class Main {
  static function main() {
    var jsonData = '[1, 2, 3]';
    var json = haxe.Json.parse(jsonData);
    $type(json); // Unknown<0>
    for (i in 0...json.length) {
	  // Array access is not allowed on
	  // {+ length : Int }
      trace(json[0]);
    }
  }
}