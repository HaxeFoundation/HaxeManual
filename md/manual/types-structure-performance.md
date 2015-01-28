## 2.5.4 Impact on Performance

Using structures and, by extension, [structural subtyping](type-system-structural-subtyping.md) has no impact on performance when compiling to [dynamic targets](dictionary.md#define-dynamic-target). However, on [static targets](dictionary.md#define-static-target) a dynamic lookup has to be performed which is typically slower than a static field access.

---

Previous section: [Class Notation for Structure Types](types-structure-class-notation.md)

Next section: [Function Type](types-function.md)