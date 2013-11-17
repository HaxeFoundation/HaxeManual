class Main {
    static function main() {
        var r = ~/world/;
        var s = "Hello, world!";
        trace(r.map(s, function(r) { return "Haxe"; })); // Hello, Haxe!
    }
}
