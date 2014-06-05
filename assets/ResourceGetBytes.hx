class Main {
  static function main() {
    var bytes =
      haxe.Resource.getBytes("welcome");
    trace(bytes.readString(0, bytes.length));
  }
}
