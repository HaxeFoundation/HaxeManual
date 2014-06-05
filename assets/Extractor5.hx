class Main {
  static public function main() {
    switch("foo") {
      // Extractors in or patterns are not
      // allowed
      case (_.toLowerCase() => "foo") | "bar":
    }
  }
}