class Main {
    static function main() {
        var vec = new haxe.ds.Vector(10);

        for (i in 0...vec.length) {
            vec[i] = i;
        }

        trace(vec[0]); // 0
        trace(vec[5]); // 5
        trace(vec[9]); // 9
    }
}
