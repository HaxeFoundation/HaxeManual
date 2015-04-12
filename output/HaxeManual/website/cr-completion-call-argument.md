## 8.3.3 Call argument completion

Call argument completion is triggered after an opening parenthesis character `(` to show the type of the function that is currently being called. It works for any function call as well as constructor calls:

```haxe
class Main {
  public static function main() {
    trace("Hello".split(|
  }
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0`. The output looks like this:

```haxe
<type>
delimiter : String -&gt; Array&lt;String&gt;
</type>
```

IDEs can parse this to recognize that the called function requires one argument named `delimiter` of type `String` and returns an `Array<String>`.

> ##### Trivia: Problems with the output structure
>
> We acknowledge that the current format requires a bit of manual parsing which can be annoying. In the future we might look into providing a more structured output, especially for functions.

---

Previous section: [Field access completion](cr-completion-field-access.md)

Next section: [Type path completion](cr-completion-type-path.md)