class Main {
  static public function main() {
    var a = [
      for (x in 0...5)
        for (y in 0...5)
          if (x != y)
            x => y
    ];
    // {0 => 4, 1 => 4, 2 => 4, 3 => 4, 4 => 3}
    trace(a);
  }
}
