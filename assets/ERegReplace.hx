class Main {
    static function main() {
        var str = "aaabcbcbcbz";
        var r = ~/b[^c]/g; // g : replace all instances
        trace(r.replace(str,"xx")); // "aaabcbcbcxx"
    }
}
