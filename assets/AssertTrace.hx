class Main {
  static function assert(cond:Bool, ?pos:haxe.PosInfos) {
    if (!cond)
      haxe.Log.trace("Assert in " + pos.className + "::" + pos.methodName, pos);
  }

  static function main() {
    assert(1 == 1); // nothing
    assert(0 == 3); // trace "Assert in Test::main"
  }
}
