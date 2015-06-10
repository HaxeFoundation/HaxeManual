@:genericBuild(GenericBuildMacro2.build())
class MyType<Const> { }

class Main {
  static function main() {
    var x:MyType<"myfile.txt">;
  }
}