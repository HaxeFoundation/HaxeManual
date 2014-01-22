## 10.4.3 Integer Math

If you are targeting a platform that can utilize integer operations, e.g. integer division, for performance gains, wrap the operation in **Std.int()**.  The Haxe Compiler can then optimize for integer operations.  An example:
```haxe
	var intDivision = Std.int(6.2/4.7);
```

---

Previous section: [Mathematical Errors](std-math-mathematical-errors.md)

Next section: [Extensions](std-math-extensions.md)