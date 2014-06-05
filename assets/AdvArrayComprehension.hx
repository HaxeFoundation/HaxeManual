class AdvArrayComprehension {
  static public function main() {
    var a = [
      for (a in 1...11)
        for(b in 2...4)
          if (a % b == 0)
            a+ "/" +b
    ];
    // [2/2,3/3,4/2,6/2,6/3,8/2,9/3,10/2]
    trace(a);
  }
}
