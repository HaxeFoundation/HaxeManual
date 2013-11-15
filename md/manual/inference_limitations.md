## 3.6.2 Limitations

Type inference saves a lot of manual type hints when working with local variables, but sometimes the type system still needs some help. In fact, it does not even try to infer the type of a [variable](variable.md) or [property](property.md) field unless it has a direct initialization.

There are also some cases involving recursion where type inference has limitations. If a function calls itself recursively while its type is not (completely) known yet, type inference may infer a wrong, too specialized type.

---

Previous section: [Top-down Inference](top-down_inference.md)

Next section: [Modules and Paths](modules_and_paths.md)