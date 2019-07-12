var myArray = [7, 6];
var s = switch (myArray) {
    case [a, b] if (b > a):
      b + ">" + a;
    case [a, b]:
      b + "<=" + a;
    case _: "found something else";
  }
trace(s); // 6<=7
