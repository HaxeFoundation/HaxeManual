class Main {
  static public function main() {
    var user:haxe.DynamicAccess<Dynamic> = {};

    // Sets values for specified keys.
    user.set("name", "Mark");
    user.set("age", 25);

    // Returns values by specified keys.
    trace(user.get("name")); // "Mark"
    trace(user.get("age")); // 25

    // Tells if the structure contains a specified key
    trace(user.exists("name")); // true
  }
}
