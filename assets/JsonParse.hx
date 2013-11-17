class Main {
    static function main() {
        var s = '{"rating": 5}';
        var o = haxe.Json.parse(s);
        trace(o); // { rating: 5 }
    }
}
