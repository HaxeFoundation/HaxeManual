## 6.3.4 Structure matching

It is now also possible to match against the fields of anonymous structures and instances:

```haxe
var myStructure = { name: "haxe", rating: "awesome" };
var value = switch(myStructure) {
	case { name: "haxe", rating: "poor" } : throw false;
	case { rating: "awesome", name: n } : n;
	case _: "no awesome language found";
}
trace(value); // haxe
```

Note that in the second case, we bind the matched `name` field to identifier `n` if `rating` matches `"awesome"`. Of course you could also put this structure into the `Tree` from the previous example and combine structure and enum matching.

A limitation with regards to class instances is that you cannot match against fields of their parent class.

---

Previous section: [Variable capture](lf-pattern-matching-variable-capture.md)

Next section: [Array matching](lf-pattern-matching-array.md)