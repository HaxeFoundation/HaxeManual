enum Test {
  TString(s:String);
  TInt(i:Int);
}

class Main {
  static public function main() {
    var e = TInt(4);
    var success = switch(e) {
      case TInt(lessThan(_, 5) => true): true;
      case _: false;
    }
    trace(success);
  }

  static function lessThan(lhs:Int, rhs:Int) {
    return lhs < rhs;
  }
}