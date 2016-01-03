## 12.1.3 Inject raw JavaScript

In Haxe, it is possible to call an exposed function thanks to the `untyped` keyword. This can be useful in some cases if we don't want to write externs. Anything untyped that is valid syntax will be generated as it is.

```haxe
untyped window.trackEvent("page1");  
```

---

Previous section: [Using external JavaScript libraries](target-javascript-external-libraries.md)

Next section: [JavaScript untyped functions](target-javascript-untyped.md)