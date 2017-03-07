## 6.1 Conditional Compilation

Haxe allows conditional compilation by using `#if`, `#elseif` and `#else` and checking for **compiler flags**.

> ##### Define: Compiler Flag
>
> A compiler flag is a configurable value which may influence the compilation process. Such a flag can be set by invoking the command line with `-D key=value` or just `-D key`, in which case the value defaults to `"1"`. The compiler also sets several flags internally to pass information between different compilation steps.

This example demonstrates usage of conditional compilation:

```haxe
class Main {
  public static function main(){
    #if !debug
      trace("ok");
    #elseif (debug_level > 3)
      trace(3);
    #else
      trace("debug level too low");
    #end
  }
}
```

Compiling this without any flags will leave only the `trace("ok");` line in the body of the `main` method. The other branches are discarded while parsing the file. These other branches must still contain valid Haxe syntax, but the code is not type-checked.

The conditions after `#if` and `#elseif` allow the following expressions:

* Any identifier is replaced by the value of the compiler flag by the same name. Note that `-D some-flag` from command line leads to the flags `some-flag` and `some_flag` to be defined.
* The values of `String`, `Int` and `Float` constants are used directly.
* The boolean operators `&&` (and), `||` (or) and `!` (not) work as expected, however the full expression must be completely contained by parentheses.
* The operators `==`, `!=`, `>`, `>=`, `<`, `<=` can be used to compare values.
* Parentheses `()` can be used to group expressions as usual.

The Haxe parser does not parse `some-flag` as a single token and instead reads it as a subtraction binary operator `some - flag`. In cases like this the underscore version `some_flag` has to be used.

##### Built-in Compiler Flags
An exhaustive list of all built-in defines can be obtained by invoking the Haxe Compiler with the `--help-defines` argument. The Haxe Compiler allows multiple `-D` flags per compilation.

##### Related content

* See also the [Compiler Flags list](compiler-usage-flags.md).

---

Previous section: [Language Features](lf.md)

Next section: [Externs](lf-externs.md)