abstract MyAbstract(String) from String {
  @:op([]) public function arrayRead(n:Int)
    return this.charCodeAt(n);

  @:op([]) public function arrayWrite(n:Int, char:String)
    return this.substr(0, n) + char + this.substr(n + 1);

  @:op(a.b) public function fieldRead(name:String)
    return this.indexOf(name);

  @:op(a.b) public function fieldWrite(name:String, value:String)
    return this.split(name).join(value);
}

class Main {
  static public function main() {
    var s:MyAbstract = "example string";
    trace(s[1]); // "x"
    trace(s[2] = "e"); // "exemple string"
    trace(s.string); // 8
    trace(s.string = "code"); // "exemple code"
  }
}
