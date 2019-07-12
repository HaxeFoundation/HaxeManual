var match = switch (7) {
    case 4 | 1: "0";
    case 6 | 7: "1";
    case _: "2";
  }
trace(match); // 1
