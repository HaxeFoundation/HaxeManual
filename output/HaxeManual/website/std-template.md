## 10.6 Template

Haxe comes with a standard template system with an easy to use syntax which is interpreted by a lightweight class called [haxe.Template](http://api.haxe.org/haxe/Template.html).

A template is a string or a file that is used to produce any kind of string output depending on the input. Here is a small template example:

```haxe
class Main {
  static function main() {
    var sample = "My name is <strong>::name::</strong>, <em>::age::</em> years old";
    var user = {name:"Mark", age:30};
    var template = new haxe.Template(sample);
    var output = template.execute(user);
    trace(output);
  }
}

```

The console will trace `My name is Mark, 30 years old`.

###### Expressions
An expression can be put between the `::`, the syntax allows the current possibilities:

* `::name::` the variable name
* `::expr.field::` field access
* `::(expr)::` the expression expr is evaluated
* `::(e1 op e2)::` the operation op is applied to e1 and e2
* `::(135)::` the integer 135. Float constants are not allowed

###### Conditions
It is possible to test conditions using `::if flag1::`. Optionally, the condition may be followed by `::elseif flag2::` or `::else::`. Close the condition with `::end::`.

```haxe 
::if isValid:: valid ::else:: invalid ::end::
``` 

Operators can be used but they don't deal with operator precedence. Therefore it is required to enclose each operation in parentheses `()`. Currently, the following operators are allowed: `+`, `-`, `*`, `/`, `>`, `<`,  `>=`, `<=`, `==`, `!=`, `&&` and `||`.

For example `::((1 + 3) == (2 + 2))::` will display true. 

```haxe 
::if (points == 10):: Great! ::end::
``` 

To compare to a string, use double quotes `"` in the template.
```haxe 
::if (name == "Mark"):: Hi Mark ::end::
``` 

###### Iterating
Iterate on a structure by using `::foreach::`. End the loop with `::end::`.
```haxe 
<table>
	<tr>
		<th>Name</th>
		<th>Age</th>
	</tr>
	::foreach users::
		<tr>
			<td>::name::</td>
			<td>::age::</td>
		</tr>
	::end::
</table>
``` 

###### Sub-templates
To include templates in other templates, pass the sub-template result string as a parameter.
```haxe 
var users = [{name:"Mark", age:30}, {name:"John", age:45}];

var userTemplate = new haxe.Template("::foreach users:: ::name::(::age::) ::end::");
var userOutput = userTemplate.execute({users: users});

var template = new haxe.Template("The users are ::users::");
var output = template.execute({users: userOutput});
trace(output);
``` 
The console will trace `The users are Mark(30) John(45)`.

###### Template macros
To call custom functions while parts of the template are being rendered, provide a `macros` object to the argument of [Template.execute](http://api.haxe.org/haxe/Template.html#execute). The key will act as the template variable name, the value refers to a callback function that should return a `String`. The first argument of this macro function is always a `resolve()` method, followed by the given arguments. The resolve function can be called to retrieve values from the template context. If `macros` has no such field, the result is unspecified.

The following example passes itself as macro function context and executes `display` from the template.
```haxe
class Main {
  static function main() {
    new Main();
  }

  public function new() {
    var user = {name:"Mark", distance:3500};
    var sample = "The results: $$display(::user::,::time::)";
    var template = new haxe.Template(sample);
    var output = template.execute({user:user, time: 15}, this);
    trace(output);
  }

  function display(resolve:String->Dynamic, user:User, time:Int) {
    return user.name + " ran " + (user.distance/1000) + " kilometers in " + time + " minutes";
  }
}
typedef User = {name:String, distance:Int}

```
The console will trace `The results: Mark ran 3.5 kilometers in 15 minutes`.

###### Globals
Use the [Template.globals](http://api.haxe.org/haxe/Template.html#globals) object to store values that should be applied across all `haxe.Template` instances. This has lower priority than the context argument of `Template.execute`.

###### Using resources

To separate the content from the code, consider using the [resource embedding system](cr-resources.md). 
Place the template-content in a new file called `sample.mtt`, add `-resource sample.mtt@my_sample` to the compiler arguments and retrieve the content using `haxe.Resource.getString`.
```haxe
class Main {
  static function main() {
    var sample = haxe.Resource.getString("my_sample");
    var user = {name:"Mark", age:30};
    var template = new haxe.Template(sample);
    var output = template.execute(user);
    trace(output);
  }
}

```

When running the template system on the server side, you can simply use `neko.Lib.print` or `php.Lib.print` instead of trace to display the HTML template to the user.

See the [Template API](http://api.haxe.org/haxe/Template.html) for details about its methods.

---

Previous section: [Lambda](std-Lambda.md)

Next section: [Reflection](std-reflection.md)