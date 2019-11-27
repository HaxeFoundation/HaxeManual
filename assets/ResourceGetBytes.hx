class Main {
  static function main() {
    var bytes = haxe.Resource.getBytes("welcome");
    trace(bytes.getString(0, bytes.length));
  }
}
