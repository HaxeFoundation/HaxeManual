## 3 Type System

We learned about the different kinds of types in [Types](https://github.com/Simn/HaxeManual/tree/master/md/manual/2-Types.md) and it is now time to see how they interact with each other. We start off easy by introducing [Typedef](https://github.com/Simn/HaxeManual/tree/master/md/manual/3.1-Typedef.md), a mechanism to give a name (or alias) to a more complex type. Among other things, this will come in handy when working with types having [Type Parameters](https://github.com/Simn/HaxeManual/tree/master/md/manual/3.2-Type_Parameters.md).

A lot of type-safety is achieved by checking if two given types of above type groups are compatible. That is, the compiler tries to perform **unification** between them, as detailed in [Unification](https://github.com/Simn/HaxeManual/tree/master/md/manual/3.3-Unification.md).

All types are organized in **modules** and can be addressed through **paths**. [Modules and Paths](https://github.com/Simn/HaxeManual/tree/master/md/manual/3.5-Modules_and_Paths.md) will give a detailed explanation of the related mechanics.