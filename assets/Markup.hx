import haxe.macro.Expr;

class Markup {
  public static macro function process(markup:Expr):Expr {
    switch (markup) {
      case macro @:markup $v{(s : String)}:
        return macro $v{s.split("markup").join("processed markup")};
      case _:
        throw "expected markup";
    }
  }
}

class Main {
  public static function main() {
    var result = Markup.process(<div>some<b>markup</b></div>);
    trace(result); // <div>some <b>processed markup</b></div>
  }
}
