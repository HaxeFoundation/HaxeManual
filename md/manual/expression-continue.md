## 5.19 continue

The `continue` keyword ends the current iteration of the innermost loop (`for` or `while`) it is declared in, causing the loop condition to be checked for the next iteration:

```haxe
while(true) {
	expression1;
	if(condition) continue;
	expression2;
}
```

Here, `expression1` is evaluated for each iteration, but if `condition` holds, `expression2` is not evaluated for the current iteration. Unlike `break`, iterations continue.

The typer ensures that it appears only within a loop.

---

Previous section: [break](expression-break.md)

Next section: [Language Features](lf.md)