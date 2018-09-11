import haxe.Constraints;

class Main {
  static public function main() {
    var s:String = make();
    var t:haxe.Template = make();
  }

  @:generic
  static function make<T:Constructible<String->Void>>():T {
    return new T("foo");
  }
}
