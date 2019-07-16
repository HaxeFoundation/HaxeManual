var myArray = [1, 6];

var match = switch (myArray) {
    case [2, _]: "0";
    case [_, 6]: "1";
    case []: "2";
    case [_, _, _]: "3";
    case _: "4";
  }
trace(match); // 1
