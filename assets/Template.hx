class Main {
  static function main() {
    var sample = "My name is <strong>::name::</strong>, <em>::age::</em> years old";
    var user = {name: "Mark", age: 30};
    var template = new haxe.Template(sample);
    var output = template.execute(user);
    trace(output);
  }
}
