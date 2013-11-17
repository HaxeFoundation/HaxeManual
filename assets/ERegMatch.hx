class Main {
    static function main() {
        var r = ~/world/;
        var str = "hello world";
        trace(r.match(str)); // true : 'world' was found in the string
        trace(r.match("hello !")); // false
    }
}
