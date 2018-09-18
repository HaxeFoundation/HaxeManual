## 2.1.3 Numeric Operators

This the list of numeric operators in Haxe, grouped by descending priority.

##### Unary
 
 Operator  | Operation  | Operand 1  | Operand 2  | Return 
 --- | --- | --- | --- | ---
<code>~</code> | bitwise negation  | `Int`  | N/A  | `Int` 
<code>+</code> | plus  | `Float/Int`  | N/A  | `Float/Int` 
<code>-</code> | minus  | `Float/Int`  | N/A  | `Float/Int` 
<code>++</code> | increment  | `Float/Int`  | N/A  | `Float/Int` 
<code>--</code>  | decrement  | `Float/Int`  | N/A  | `Float/Int` 
 
##### Arithmetic
 
 Operator  | Operation  | Operand 1  | Operand 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>%</code>  | modulo  | `Float/Int`  | `Float/Int`  | `Float/Int` 
 
#####  
 
 Operator  | Operation  | Operand 1  | Operand 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>*</code>  | multiplication  | `Float/Int`  | `Float/Int`  | `Float/Int` 
<code>/</code>  | division  | `Float/Int`  | `Float/Int`  | `Float` 
 
#####  
 
 Operator  | Operation  | Operand 1  | Operand 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>+</code>  | addition  | `Float/Int`  | `Float/Int`  | `Float/Int` 
<code>-</code>  | subtraction  | `Float/Int`  | `Float/Int`  | `Float/Int` 
 About `Float/Int` return type: If one of the operands is of type `Float`, the resulting expression will also be of type `Float`, otherwise the type will be `Int`.
##### Bitwise
 
 Operator  | Operation  | Operand 1  | Operand 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>&lt;&lt;</code>  | shift left  | `Int`  | `Int`  | `Int` 
<code>&gt;&gt;</code>  | shift right  | `Int`  | `Int`  | `Int` 
<code>&gt;&gt;&gt;</code>  | unsigned shift right  | `Int`  | `Int`  | `Int` 
 
#####  
 
 Operator  | Operation  | Operand 1  | Operand 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>&amp;</code>  | bitwise and  | `Int`  | `Int`  | `Int` 
<code>&#124;</code>  | bitwise or  | `Int`  | `Int`  | `Int` 
<code>^</code>  | bitwise xor  | `Int`  | `Int`  | `Int` 
 
##### Comparison
 
 Operator  | Operation  | Operand 1  | Operand 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>==</code>  | equal  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>!=</code>  | not equal  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&lt;</code>  | less than  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&lt;=</code>  | less than or equal  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&gt;</code>  | greater than  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&gt;=</code>  | great than or equal  | `Float/Int`  | `Float/Int`  | `Bool` 
 

##### Equality

**For enums:**

* Enum without parameters Are always represent the same value, so `MyEnum.A == MyEnum.A`. 
* Enum with parameters Can be compared with `a.equals(b)` (which is a short for `Type.enumEquals()`).

**Dynamic:**
Comparison involving at least one Dynamic value is unspecifed and platform-specific.

##### Differences with other languages

Haxe precedence differ from other languages for the following cases:

* `%` have lower precedence than `*` and `/` whereas in C these three have the same
* `|`, `&` and `^` have the same precedence in Haxe, so they will be always grouped from left-to-right, whereas in C `&` have lower precedence than `^` which itself have lower precedence than `|`
* `|`, `&` and `^` also have lower precedence than `==` and `!=` in Haxe

---

Previous section: [Overflow](types-overflow.md)

Next section: [Bool](types-bool.md)