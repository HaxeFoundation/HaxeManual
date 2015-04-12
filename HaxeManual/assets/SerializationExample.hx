import haxe.Serializer;
import haxe.Unserializer;

class Main {
  static function main() {
    var serializer = new Serializer();
    serializer.serialize("foo");
    serializer.serialize(12);
    var s = serializer.toString();
    trace(s); // y3:fooi12

    var unserializer = new Unserializer(s);
    trace(unserializer.unserialize()); // foo
    trace(unserializer.unserialize()); // 12
  }
}