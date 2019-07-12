class Main {
  static public function main() {
    var myList = new haxe.ds.List<Int>();
    for (ii in 0...5)
      myList.add(ii);
    trace(myList); // {0, 1, 2, 3, 4}
  }
}
