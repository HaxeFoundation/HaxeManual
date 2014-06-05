class Main {
  static public function main() {
    var scores = [110, 170, 35];
    var sum = 0;
    for (score in scores) {
      sum += score;
    }
    trace(sum); // 315
  }
}