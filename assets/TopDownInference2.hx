class Main {
  static public function main() {
    var t = Type.typeof("foo");
    switch(t) {
      case TObject:
      case TFunction:
      default:
    }
  }
}