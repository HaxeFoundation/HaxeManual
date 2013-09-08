It is also possible to further restrict patterns with the `case ... if(condition):` syntax:

```
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