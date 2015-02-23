abstract MyAbstractInt(Int) from Int to Int {
    // The following line exposes the (A > B) operation from the underlying Int type.
    // Note that no function body is used:
    @:op(A > B) static function gt( a:MyAbstractInt, b:MyAbstractInt ) : Bool;
}

class Main {
    static function main() {
        var a:MyAbstractInt = 42;
        if(a > 0) trace('Works fine, > operation implemented!');   

        // The < operator is not implemented.
        // This will cause an 'Cannot compare MyAbstractInt and Int' error:
        if(a < 100) { }
    }
}
