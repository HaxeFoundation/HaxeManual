class Main {
  static function setAnyValue(value:Any) {
    trace(value);
  }

  static function getAnyValue():Any {
    return 42;
  }

  static function main() {
    // value of any type works
    setAnyValue("someValue");
    setAnyValue(42);

    var value = getAnyValue();
    $type(value); // Any, not Unknown<0>

    // won't compile: no dynamic field access
    // value.charCodeAt(0);

    if (Std.is(value, String)) {
      // explicit promotion, type-safe
      trace((value : String).charCodeAt(0));
    }
  }
}
