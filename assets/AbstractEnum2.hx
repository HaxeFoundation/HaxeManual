enum abstract Numeric(Int) {
  var Zero; // implicit value: 0
  var Ten = 10;
  var Eleven; // implicit value: 11
}

enum abstract Textual(String) {
  var FirstCase; // implicit value: "FirstCase"
  var AnotherCase; // implicit value: "AnotherCase"
}
