@:build(EnumBuildingMacro.build())
enum E { }

class Main {
  static public function main() {
    switch(E.A) {
      case A:
      case B(v):
    }
  }
}