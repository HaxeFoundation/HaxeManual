class Example<T = Int, U = Int> {
  public var a:T;
  public var b:U;
  public function new() {}
}

function main():Void {
  var x:Example = new Example();
  $type(x.a); // Int
  $type(x.b); // Int

  var y:Example<Bool> = new Example();
  $type(y.a); // Bool
  $type(y.b); // Int

  var z:Example<String, Int> = new Example();
  $type(z.a); // String
  $type(z.b); // Int
}
