## 10.14.1 SPOD Objects

Declare a SPOD Object by extending the `sys.db.Object` class:

```haxe 
import sys.db.Types;
class User extends sys.db.Object {
    public var id:SId;
    public var name:SString<32>;
    public var birthday:SDate;
    public var phoneNumber:SNull<SText>;
}
``` 

Special types are declared in `sys.db.Types` in order to provide additional information for SPOD. See [complete list of types and related SQL types](std-spod-supported-types.md).

###### Insert
In order to insert a new SPOD, simply do the following:

```haxe 
var user = new User();
user.name = "Random156";
user.birthday = Date.now();
user.insert();
``` 

After the `insert()` is done, the auto increment unique id will be set and all fields that were null but not declared as nullable will be set to their default value (`0` for numbers, `""` for strings and empty bytes for binaries).

###### Update
Once there is an instance of the SPOD object, modify its fields and call `update()` to send these changes to the database.

```haxe 
var user = User.manager.get(1);
if( user.phoneNumber == null) user.phoneNumber = "+3360000000";
user.update();
``` 

###### Delete
Use `delete()` to delete the SPOD object from the database.

```haxe 
var user = User.manager.get(1);
if (user != null) user.delete();
```

---

Previous section: [SPOD](std-spod.md)

Next section: [Initialization](std-spod-initialization.md)