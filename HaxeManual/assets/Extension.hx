typedef IterableWithLength<T> = {
  > Iterable<T>,
  // read only property
  var length(default, null):Int;
}

class Extension {
  static public function main() {
    var array = [1, 2, 3];
    var t:IterableWithLength<Int> = array;
  }
}