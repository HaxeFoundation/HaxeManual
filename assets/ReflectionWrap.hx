typedef MyStructure = {
  name: String,
  score: Int
}

class Main {
  static function main() {
    var data = reflective();
    // At this point data is nicely typed as
    // MyStructure
  }

  static function reflective():MyStructure {
    // Work with reflection here to get some
    // values we want to return.
    return {
      name: "Reflection",
      score: 0
    }
  }
}
