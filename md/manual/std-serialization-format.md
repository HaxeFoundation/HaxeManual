## 10.8.1 Serialization format

Each supported value is translated to a distinct prefix character, followed by the necessary data.

* `null`: `n`
* `Int`: `z` for zero, or `i` followed by the integer display (e.g. `i456`)
* `Float`: 

    * `NaN`: `k`
    * negative infinity: `m`
    * positive infinity: `p`
    * finite floats: `d` followed by the float display (e.g. `d1.45e-8`)
* `Bool`: `t` for `true`, `f` for `false`
* `String`: `y` followed by the url encoded string length, then `:` and the url encoded string (e.g. `y10:hi%20there for "hi there".`
* name-value pairs: a serialized string representing the name followed by the serialized value
* structure: `o` followed by the list of name-value pairs and terminated by `g` (e.g. `oy1:xi2y1:kng` for `{x:2, k:null}`)
* `List`: `l` followed by the list of serialized items, followed by `h` (e.g. `lnnh` for a list of two `null` values)
* `Array`: `a` followed by the list of serialized items, followed by `h`. For multiple consecutive `null` values, `u` followed by the number of `null` values is used (e.g. `ai1i2u4i7ni9h for [1,2,null,null,null,null,7,null,9]`)
* `Date`: `v` followed by the date itself (e.g. `v2010-01-01 12:45:10`)
* `haxe.ds.StringMap`: `b` followed by the name-value pairs, followed by `h` (e.g. `by1:xi2y1:knh` for `{"x" => 2, "k" => null}`)
* `haxe.ds.IntMap`: `q` followed by the key-value pairs, followed by `h`. Each key is represented as `:<int>` (e.g. `q:4n:5i45:6i7h` for `{4 => null, 5 => 45, 6 => 7}`)
* `haxe.ds.ObjectMap`: `M` followed by serialized value pairs representing the key and value, followed by `h`
* `haxe.io.Bytes`: `s` followed by the length of the base64 encoded bytes, then `:` and the byte representation using the codes `A-Za-z0-9%` (e.g. `s3:AAA` for 2 bytes equal to `0`, and `s10:SGVsbG8gIQ` for `haxe.io.Bytes.ofString("Hello !")`)
* exception: `x` followed by the exception value
* class instance: `c` followed by the serialized class name, followed by the name-value pairs of the fields, followed by `g` (e.g. `cy5:Pointy1:xzy1:yzg` for `new Point(0, 0)` (having two integer fields `x` and `y`)        
* enum instance (by name): `w` followed by the serialized enum name, followed by the serialized constructor name, followed by `:`, followed by the number of arguments, followed by the argument values (e.g. `wy3:Fooy1:A:0` for `Foo.A` (with no arguments), `wy3:Fooy1:B:2i4n` for `Foo.B(4,null)`)
* enum instance (by index): `j` followed by the serialized enum name, followed by `:`, followed by the constructor index (starting from 0), followed by `:`, followed by the number of arguments, followed by the argument values (e.g. `wy3:Foo:0:0` for `Foo.A` (with no arguments), `wy3:Foo:1:2i4n` for `Foo.B(4,null)`)
* cache references: 

    * `String`: `R` followed by the corresponding index in the string cache (e.g. `R456`)
    * class, enum or structure `r` followed by the corresponding index in the object cache (e.g. `r42`)
* custom: `C` followed by the class name, followed by the custom serialized data, followed by `g`

 Cached elements and enum constructors are indexed from zero.

---

Previous section: [Serialization](std-serialization.md)

Next section: [Json](std-Json.md)