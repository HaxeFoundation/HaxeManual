## 3 Type System

We learned about the different kinds of types in [Types](types.md) and it is now time to see how they interact with each other. We start off easy by introducing [typedef](type-system-typedef.md), a mechanism to give a name (or alias) to a more complex type. Among other things, this will come in handy when working with types having [type parameters](type-system-type-parameters.md).

A lot of type-safety is achieved by checking if two given types of above type groups are compatible. That is, the compiler tries to perform **unification** between them, as detailed in [Unification](type-system-unification.md).

All types are organized in **modules** and can be addressed through **paths**. [Modules and Paths](type-system-modules-and-paths.md) will give a detailed explanation of the related mechanics.

---

Previous section: [Monomorph](types-monomorph.md)

Next section: [Typedef](type-system-typedef.md)