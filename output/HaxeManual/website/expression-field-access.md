## 5.7 Field Access

Field access is expressed by using the dot `.` followed by the name of the field.

```haxe
object.fieldName
```

This syntax is also used to access types within packages in the form of `pack.Type`.

The typer ensures that an accessed field actually exist and may apply transformations depending on the nature of the field. If a field access is ambiguous, understanding the [resolution order](type-system-resolution-order.md) may help.

---

Previous section: [Object Declaration](expression-object-declaration.md)

Next section: [Array Access](expression-array-access.md)