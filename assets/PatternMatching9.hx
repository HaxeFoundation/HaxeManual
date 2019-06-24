var s = switch [1, false, "foo"] {
  case [1, false, "bar"]: "0";
  case [_, true, _]: "1";
  case [_, false, _]: "2";
}
trace(s); // 2