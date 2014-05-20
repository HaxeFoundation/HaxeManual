## 3.4 Variance

While variance is relevant in other places, it occurs particularly often with type parameters and often comes as a surprise in this context. It is also very easy to trigger variance errors:

```haxe
class Base {
	public function new() { }
}

class Child extends Base { }

class Main {
    public static function main () {
		var children = [new Child()];
		var bases:Array<Base> = children; // Array<Child> should be Array<Base>
			// Type parameters are invariant
			// Child should be Base
    }
}
```

Apparently, an `Array<Child>` cannot be assigned to an `Array<Base>`, even though `Child` can be assigned to `Base`. The reason for this might be somewhat unexpected: It is not allowed because arrays can be written to, e.g. via their `push()` method. It is easy to generate problems by ignoring variance errors:

```haxe
class Base {
	public function new() { }
}

class Child extends Base { }

class OtherChild extends Base { }

class Main {
    public static function main () {
		var children = [new Child()];
		var bases:Array<Base> = cast children; // subvert type checker
		bases.push(new OtherChild());
		for(child in children) {
			trace(child);
		}
    }
}
```

What happens here is that we subvert the type checker by using a [cast](expression-cast.md), thus allowing the assignment in line 12. With that we hold a reference `bases` to the original array, typed as `Array<Base>`. This allows pushing another type compatible with `Base`, `OtherChild`, onto that array. However, our original reference `children` is still of type `Array<Child>`, and things go bad when we encounter the `OtherChild` instance in one of its elements while iterating.

If `Array` had no `push()` method and no other means of modification, the assignment would be safe because no incompatible type could be added to it. We can achieve this in Haxe by restricting the type accordingly using [structural subtyping](type-system-structural-subtyping.md):

```haxe
class Base {
	public function new() { }
}

class Child extends Base { }

typedef MyArray<T> = {
	public function pop():T;
}

class Main {
    public static function main () {
		var a = [new Child()];
		var b:MyArray<Base> = a;
    }
}
```

With `b` being typed as `MyArray<Base>` and `MyArray` only having a `pop()` method, we can safely assign. There is no method defined on `MyArray` which could be used to add incompatible types, it is thus said to be **covariant**.

> ##### Define: Covariance
>
> A [compound type](dictionary.md#compound-type) is considered covariant if its component types can be assigned to less specific components, i.e. if they are only read, but never written.


> ##### Define: Contravariance
>
> A [compound type](dictionary.md#compound-type) is considered contravariant if its component types can be assigned to less generic components, i.e. if they are only written, but never read.

---

Previous section: [Construction of generic type parameters](type-system-generic-type-parameter-construction.md)

Next section: [Unification](type-system-unification.md)