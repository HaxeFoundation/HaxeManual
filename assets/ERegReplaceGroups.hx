class Main {
  static function main() {
    var str = "{hello} {0} {again}";
    var r = ~/{([a-z]+)}/g;
    // "*hello* {0} *again*"
    trace(r.replace(str,"*$1*"));
  }
}
