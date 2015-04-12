import haxe.Serializer;
import haxe.Unserializer;

class Main {

    var x:Int;
    var y:Int;

    static function main() {
      var s = Serializer.run(new Main(1, 2));
      var c:Main = Unserializer.run(s);
      trace(c.x); // 1
      trace(c.y); // -1
    }

    function new(x, y) {
      this.x = x;
      this.y = y;
    }

    @:keep
    function hxSerialize(s:Serializer) {
        s.serialize(x);
    }

    @:keep
    function hxUnserialize(u:Unserializer) {
        x = u.unserialize();
        y = -1;
    }
}