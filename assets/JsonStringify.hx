class Main {
    static function main() {
        var o = {rating: 5};
        var s = haxe.Json.stringify(o);
        trace(s); // {"rating":5}
    }
}
