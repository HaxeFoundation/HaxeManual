## 4.2.3 Rules for getter and setter

Visibility of accessor methods has no effect on the accessibility of its property. That is, if a property is `public` and defined to have a getter, that getter may me defined as `private` regardless.

Both getter and setter may access their physical field for data storage. The compiler ensures that this kind of field access does not go through the accessor method if made from within the accessor method itself, thus avoiding infinite recursion:

```haxe
class Main {
  public var x(default, set):Int;

  function set_x(newX) {
    return x = newX;
  }

  static public function main() {}
}
```

However, the compiler assumes that a physical field exists only if at least one of the access identifiers is `default` or `null`.

> ##### Define: Physical field
>
> A field is considered to be **physical** if it is either
> 
> * a [variable](class-field-variable.md)
> * a [property](class-field-property.md) with the read-access or write-access identifier being `default` or `null`
> * a [property](class-field-property.md) with `:isVar` [metadata](lf-metadata.md)
> 
> 

If this is not the case, access to the field from within an accessor method causes a compilation error:

```haxe
class Main {
  // This field cannot be accessed because it is not a real variable
  public var x(get, set):Int;

  function get_x() {
    return x;
  }

  function set_x(x) {
    return this.x = x;
  }

  static public function main() {}
}

```

If a physical field is indeed intended, it can be forced by attributing the field in question with the `:isVar` [metadata](lf-metadata.md):

```haxe
class Main {
  // @isVar forces the field to be physical allowing the program to compile.
  @:isVar public var x(get, set):Int;

  function get_x() {
    return x;
  }

  function set_x(x) {
    return this.x = x;
  }

  static public function main() {}
}

```

> ##### Trivia: Property setter type
>
> It is not uncommon for new Haxe users to be surprised by the type of a setter being required to be `T->T` instead of the seemingly more natural `T->Void`. After all, why would a **setter** have to return something?
> 
> The rationale is that we still want to be able to use field assignments using setters as right-side expressions. Given a chain like `x = y = 1`, it is evaluated as `x = (y = 1)`. In order to assign the result of `y = 1` to `x`, the former must have a value. If `y` had a setter returning `Void`, this would not be possible.

---

Previous section: [Impact on the type system](class-field-property-type-system-impact.md)

Next section: [Method](class-field-method.md)