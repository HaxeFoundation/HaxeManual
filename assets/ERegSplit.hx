class Main {
    static function main() {
        var str = "XaaaYababZbbbW";
        var r = ~/[ab]+/g;
        trace(r.split(str)); // ["X","Y","Z","W"]
    }
}
