class Main {
  static public function main() {
    var a = [for (i in 0...5) i => 'number ${i}'];
    trace(a); // {0 => number 0, 1 => number 1, 2 => number 2, 3 => number 3, 4 => number 4}
    
    var i = 0;
    var b = [while(i < 5) i => 'number ${i++}'];
    trace(b); // {0 => number 0, 1 => number 1, 2 => number 2, 3 => number 3, 4 => number 4}
  }
}
