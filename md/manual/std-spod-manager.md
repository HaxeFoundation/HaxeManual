## 10.14.7 SPOD Manager

###### Manager

Each SPOD object need its own manager. The SPOD Macros will add this manager automatically. To define a custom manager (should extend `sys.db.Manager`), add the following line to your SPOD class body:

```haxe 
public static var manager = new sys.db.Manager<User>(User);
``` 

###### Get

In order to retrieve an instance of SPOD, call the `Manager.get` method by using the object unique identifier (primary key).

```haxe 
var user = User.manager.get(1);
if (user == null) throw "User #1 not found";
trace(u.name);
``` 

If a primary key with multiple values is defined, use the following declaration:

```haxe 
var userGroup = UserGroup.manager.get({uid:1, gid:2});
``` 

###### Select
To return the first result object, use the `Manager.select` method.

```haxe 
var user = User.manager.select($name == "John");
``` 

###### Count
Use the `Manager.count` method to count the number of objects matching the given search query:

```haxe 
var count = User.manager.count($name.like("J%") && $phoneNumber != null);
``` 

###### Delete
Delete all objects matching the given query:

```haxe 
User.manager.delete($id > 1000);
``` 

###### Search

To search for objects, use the `Manager.search` method.

```haxe 
var minId = 10;
for(user in User.manager.search($id < minId)) {
    trace(user);
}
``` 

In order to differentiate between the database fields and the Haxe variables, all the database fields are prefixed with a dollar in search queries.

Search queries are checked at compile-time and the following SQL code is generated instead:

```haxe 
unsafeSearch("SELECT * FROM User WHERE id < " + Manager.quoteInt(minId));
``` 

The code generator also makes sure that no SQL injection is ever possible.

###### Supported search syntax

* constants integers, floats, strings, null, true, false
* all operations `+`, `-`, `*`, `/`, `%`, `|`, `&`, `^`, `>>`, `<<`, `>>>`
* unary operations `!`, `-`, `~`
* all comparisons `==` , `>=` , `<=`, `>`, `<`, `!=`
* bool tests `&&`, `||`
* parenthesizes `()`
* calls and fields accesses compiled as Haxe expressions
 

When comparing two values with `==` or `!=` and when one of them can be `NULL`, the SQL generator is using the `<=>` SQL operator to ensure that `NULL == NULL` returns true and `NULL != NULL` returns false.

###### Additional search syntax

It is also possible to use anonymous objects to match exact values for some fields (similar to previous SPOD but typed :

```haxe 
User.manager.search({id:1, name: "Nicolas"})
// same as :
User.manager.search($id == 1 && $name == "Nicolas")
// same as :
User.manager.search($id == 1 && {name: "Nicolas"})
``` 

Use if-conditions to generate different SQL based on Haxe variables (it is not possible to use database fields in if-test) :

```haxe 
function listName( ?name : String ) {
    return User.manager.search($id < 10 && if (name == null) true else $name == name);
}
```

---

Previous section: [SPOD Metadata](std-spod-metadata.md)

Next section: [SQL functions](std-spod-sql.md)