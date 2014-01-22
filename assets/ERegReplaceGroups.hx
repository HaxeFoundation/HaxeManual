class Main {
    static function main() {
        var str = "{hello} {0} {again}";
        var r = ~/{([a-z]+)}/g;
        trace(r.replace(str,"*$1*")); // "*hello* {0} *again*"
    }
}
