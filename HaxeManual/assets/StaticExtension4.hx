@:using(Main.TreeTools)
enum Tree {
  Node(l:Tree, r:Tree);
  Leaf(value:Int);
}

class TreeTools {
  public static function sum(tree:Tree):Int {
    return (switch (tree) {
        case Node(l, r): sum(l) + sum(r);
        case Leaf(value): value;
      });
  }
}

class Main {
  static public function main() {
    var a = Node(Node(Leaf(1), Leaf(2)), Leaf(3));
    // works, even though there was no 'using Main.TreeTools' in this module
    trace(a.sum());
  }
}