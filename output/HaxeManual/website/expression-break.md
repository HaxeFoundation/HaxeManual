## 5.20 break

The `break` keyword leaves the control flow of the innermost loop (`for` or `while`) it is declared in, stopping further iterations:

```haxe
while(true) {
	expression1;
	if (condition) break;
	expression2;
}
```

Here, `expression1` is evaluated for each iteration, but as soon as `condition` holds, the current iteration is terminated without evaluating `expression2`, and no more iteration is done.

The typer ensures that it appears only within a loop. The `break` keyword in [`switch` cases](expression-switch.md) is not supported in Haxe.

---

Previous section: [return](expression-return.md)

Next section: [continue](expression-continue.md)