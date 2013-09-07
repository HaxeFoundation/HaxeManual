We learned about the different kinds of types in [manual/Types] and it is now time to see how they interact with each other. We start off easy by introducing [manual/Typedef], a mechanism to give a name (or alias) to a more complex type. Among other things, this will come in handy when working with types having [manual/Type_Parameters].

A lot of type-safety is achieved by checking if two given types of above type groups are compatible. That is, the compiler tries to perform **unification** between them, as detailed in [manual/Unification].

All types are organized in **modules** and can be addressed through **paths**. [manual/Modules_and_Paths] will give a detailed explanation of the related mechanics.