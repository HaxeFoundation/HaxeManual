## 6.3.7 Guards

It is also possible to further restrict patterns with the `case ... if(condition):` syntax:

```haxe
var myArray = [7, 6];
var s = switch(myArray) {
	case [a, b] if (b > a):
		b + ">" +a;
	case [a, b]:
		b + "<=" +a;
	case _: "found something else";
}
trace(s); // 6<=7
```

Note how the first case has an additional guard condition `if (b > a)`. It will only be selected if that condition holds, otherwise matching continues with the next case.

---

Previous section: [Or patterns](lf-pattern-matching-or.md)

Next section: [Match on multiple values](lf-pattern-matching-tuples.md)