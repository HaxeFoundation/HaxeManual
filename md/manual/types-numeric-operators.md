## 2.1.3 Numeric Operators

>TODO: make sure the types are right for inc, dec, negate, and bitwise negate




##### Arithmetic
 
 Operator  | Operation  | Argument 1  | Argument 2  | Return 
 --- | --- | --- | --- | ---
<code>++</code> | increment  | `Int`  | `N/A`  | `Int`
 |  | `Float`  | `N/A`  | `Float`
<code>--</code>  | decrement  | `Int`  | `N/A`  | `Int`
 |  | `Float`  | `N/A`  | `Float`
<code>+</code>  | addition  | `Float`  | `Float`  | `Float` 
 |  | `Float`  | `Int`  | `Float` 
 |  | `Int`  | `Float`  | `Float` 
 |  | `Int`  | `Int`  | `Int` 
<code>-</code>  | subtraction  | `Float`  | `Float`  | `Float` 
 |  | `Float`  | `Int`  | `Float` 
 |  | `Int`  | `Float`  | `Float` 
 |  | `Int`  | `Int`  | `Int` 
<code>*</code>  | multiplication  | `Float`  | `Float`  | `Float` 
 |  | `Float`  | `Int`  | `Float` 
 |  | `Int`  | `Float`  | `Float` 
 |  | `Int`  | `Int`  | `Int` 
<code>/</code>  | division  | `Float`  | `Float`  | `Float` 
 |  | `Float`  | `Int`  | `Float` 
 |  | `Int`  | `Float`  | `Float` 
 |  | `Int`  | `Int`  | `Float` 
<code>%</code>  | modulo  | `Float`  | `Float`  | `Float` 
 |  | `Float`  | `Int`  | `Float` 
 |  | `Int`  | `Float`  | `Float` 
 |  | `Int`  | `Int`  | `Int` 
 
##### Comparison
 
 Operator  | Operation  | Argument 1  | Argument 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>~</code>  | `negation`  | `Float/Int`  | `N/A`  | `Bool` 
<code>==</code>  | equal  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>!=</code>  | not equal  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&lt;</code>  | less than  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&lt;=</code>  | less than or equal  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&gt;</code>  | greater than  | `Float/Int`  | `Float/Int`  | `Bool` 
<code>&gt;=</code>  | great than or equal  | `Float/Int`  | `Float/Int`  | `Bool` 
 
##### Bitwise
 
 Operator  | Operation  | Argument 1  | Argument 2  | Return 
 --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
<code>!</code>  | bitwise negation  | `Int`  | `N/A`  | `Int` 
<code>&amp;</code>  | bitwise and  | `Int`  | `Int`  | `Int` 
<code>&#124;</code>  | bitwise or  | `Int`  | `Int`  | `Int` 
<code>^</code>  | bitwise xor  | `Int`  | `Int`  | `Int` 
<code>&lt;&lt;</code>  | shift left  | `Int`  | `Int`  | `Int` 
<code>&gt;&gt;</code>  | shift right  | `Int`  | `Int`  | `Int` 
<code>&gt;&gt;&gt;</code>  | unsigned shift right  | `Int`  | `Int`  | `Int`

---

Previous section: [Overflow](types-overflow.md)

Next section: [Bool](types-bool.md)