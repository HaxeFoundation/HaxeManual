var myStructure = {
  name: "haxe",
  rating: "awesome"
};
var value = switch(myStructure) {
  case { name: "haxe", rating: "poor" }:
    throw false;
  case { rating: "awesome", name: n }:
    n;
  case _:
    "no awesome language found";
}
trace(value); // haxe