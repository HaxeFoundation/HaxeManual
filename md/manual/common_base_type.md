## 3.5.5 Common Base Type

Given a set of multiple types, a **common base type** is a type which all types of the set unify against:

```haxe
class Base {
	public function new() { }
}

class Child1 extends Base { }
class Child2 extends Base { }

class UnifyMin {
	static public function main() {
		var a = [new Child1(), new Child2()];
		$type(a); // Array<Base>
	}
}
```
Although `Base` is not mentioned, the haxe compiler manages to infer it as the common type of `Child1` and `Child2`. The haxe compiler employs this kind of unification in the following situations:



* array declarations
* `if`/`else`
* cases of a `switch`

---

Previous section: [Function Return](function_return_unification.md)

Next section: [Type Inference](type_inference.md)