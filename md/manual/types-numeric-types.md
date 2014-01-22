## 2.1.1 Numeric types

> ##### Define: Float
>
> Represents a double-precision IEEE 64-bit floating point number.

> ##### Define: Int
>
> Represents an integral number.

While every `Int` can be used where a `Float` is expected (that is, `Int` **is assignable to** or **unifies with** `Float`), the reverse is not true: Assigning a `Float` to an `Int` might lose precision and is not implicitly allowed.

---

Previous section: [Basic Types](types-basic-types.md)

Next section: [Overflow](types-overflow.md)