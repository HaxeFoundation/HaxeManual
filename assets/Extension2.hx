typedef WithLength = {
  var length(default, null):Int;
}

typedef IterableWithLengthAndPush<T> = {
  > Iterable<T>,
  > WithLength,
  function push(a:T):Int;
}

class Extension2 {
  static public function main() {
    var array = [1, 2, 3];
    var t:IterableWithLengthAndPush<Int> =
      array;
  }
}