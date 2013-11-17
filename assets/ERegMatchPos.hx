class Main {
    static function main() {
        var str = "abcdeeeeefghi";
        var r = ~/e+/;
        r.match(str);
        trace(r.matched(0)); // "eeeee"
        trace(r.matchedPos()); // { pos : 4, len : 5 }
    }
}
