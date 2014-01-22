## 2.1 Basic Types

**Basic Types** include **Bool, Float, and Int**.  The basic types are **abstract types** tagged with **:coreType** metadata.  This means is they get replaced by platform specific types at compile-time.  Don't worry about all of the implementation details at the moment, but feel free to see [Abstract](types-abstract.md) and [Metadata](lf-metadata.md) for more details.  Just be aware that this abstraction can cause the [Overflow](types-overflow.md) and [Nullability](types-nullability.md) of Basic Types to behave differently on different target platforms.  To reiterate: **basic types can behave differently depending on the target platform.**

---

Previous section: [Types](types.md)

Next section: [Numeric types](types-numeric-types.md)