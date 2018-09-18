## 3.7.3 Import defaults / import.hx

##### since Haxe 3.3.0

This feature allows us to define default imports and usings that will be applied for all modules inside a directory, which is particularly handy for large code bases with a lot of helpers and static extensions because it reduces the amount of imports.

The special named `import.hx` file (note the lowercase name) can be placed in the directory where your code lies. The file can contain import and using statements only. The statements will be applied to all Haxe modules in this directory and its subdirectories.

Default imports of `import.hx` acts as if its contents is placed at the top of each module. 

##### Related content

* [Introduction of `import.hx`](https://haxe.org/blog/importhx-intro/)

---

Previous section: [Import](type-system-import.md)

Next section: [Resolution Order](type-system-resolution-order.md)