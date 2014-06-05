class Main {
  static public function main() {
    var f = 0.0;
    do {
      trace(f);
      f = Math.random();
    } while(f < 0.5);
  }
}