## 6.3.5 Array matching

Arrays can be matched on fixed length:

```haxe
var myArray = [1, 6];
var match = switch(myArray) {
	case [2, _]: "0";
	case [_, 6]: "1";
	case []: "2";
	case [_, _, _]: "3";
	case _: "4";
}
trace(match); // 1
```

This will trace `1` because `array[1]` matches `6`, and `array[0]` is allowed to be anything.

---

Previous section: [Structure matching](lf-pattern-matching-structure.md)

Next section: [Or patterns](lf-pattern-matching-or.md)