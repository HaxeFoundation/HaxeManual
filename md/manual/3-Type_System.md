## 3 Type System

We learned about the different kinds of types in [Types](2-Types.md) and it is now time to see how they interact with each other. We start off easy by introducing [typedef](3.1-Typedef.md), a mechanism to give a name (or alias) to a more complex type. Among other things, this will come in handy when working with types having [type parameters](3.2-Type_Parameters.md).

A lot of type-safety is achieved by checking if two given types of above type groups are compatible. That is, the compiler tries to perform **unification** between them, as detailed in [Unification](3.3-Unification.md).

All types are organized in **modules** and can be addressed through **paths**. [Modules and Paths](3.5-Modules_and_Paths.md) will give a detailed explanation of the related mechanics.

---

Previous section: [Monomorph](2.9-Monomorph.md)

Next section: [Typedef](3.1-Typedef.md)