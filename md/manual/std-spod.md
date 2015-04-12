## 10.14 SPOD

The Simple Persistent Objects Database library, also known as SPOD, makes it possible to write Haxe expressions instead of database queries, while keeping type-safety.

### 10.14.1 SPOD Objects

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

### 10.14.2 Initialization

There are two static methods that might be needed to call before/after using SPOD:

* `sys.db.Manager.initialize()` will initialize the created managers. Make sure to call it at least once before using SPOD.
* `sys.db.Manager.cleanup()` will cleanup the temporary object cache. This can be done if you are using server module caching to free memory or after a rollback to make sure that we don't use the cached object version.

### 10.14.3 Making connection

Connect to your database and create tables directly from code without writing SQL. For instance, by using `sys.db.Mysql`. 

```haxe 
var cnx = sys.db.Mysql.connect({
   host : "localhost",
   port : null,
   user : "root",
   pass : "",
   database : "testBase",
   socket : null,
});
sys.db.Manager.cnx = cnx;
```

### 10.14.4 Creating tables

Calling `sys.db.TableCreate.create` will execute a `CREATE TABLE SQL` request based on the SPOD infos.

```haxe 
if (!sys.db.TableCreate.exists(User.manager)) {
    sys.db.TableCreate.create(User.manager);
}
``` 

Please note that currently `TableCreate` will not create the index or initialize the relations of your table.

### 10.14.5 SPOD Supported types

##### Supported types
 
 Haxe Type  |  SQL Type   |  Description 
 --- | --- | ---
`Int`, <code>SInt</code>  | <code>SSQL</code> INT  | a classic 32 bits signed integer 
`Float`, <code>SFloat</code>  | <code>SQL DOUBLE</code>  | a double precision float value  
`Bool` <code>SBool</code>   | <code>SQL TINYINT(1)</code> or <code>BOOL</code>  | a boolean value 
`Date`, <code>SDateTime</code>   | <code>SQL DATETIME</code>  | a complete date value 
`SDate`   | <code>SQL DATE</code>  | a date-only value 
`SString<K>`   | <code>SQL VARCHAR(K)</code>  | a size-limited string value 
`String`, <code>SText</code>   | <code>SQL MEDIUMTEXT</code>  | a text up to 16 MB 
`SBytes<K>`   | <code>SQL BINARY(K)</code>  | a fixed-size bytes value 
`SBinary`, `haxe.io.Bytes`   | <code>SQL MEDIUMBLOB</code>  | up to 16 MB bytes 
`SId`   | <code>SQL INT AUTO INCREMENT</code>  | same as <code>SInt</code> but used as an unique ID with auto increment 
`SEnum<E>`   | <code>SQL TINYINT UNSIGNED</code>  | a single enum without parameters which index is stored as a small integer 
`SFlags<E>`   |   | a 32 bits flag that uses an enum as bit markers. See `haxe.EnumFlags` 
`SData<Anything>`   |    | allow arbitrary serialized data (see below) 
`Null<T>`, `SNull<T>`  |  | tells that this field can be <code>NULL</code> in the database 

###### Advanced Types

The following advanced types are also available to use specific storage size:

##### Supported advanced types
 
 Haxe Type  |  SQL Type   |  Description 
 --- | --- | ---
<code>SUInt</code>  | <code>SQL UNSIGNED INT</code>  | an unsigned 32 bits integer 
<code>STinyInt</code>, <code>STinyUInt</code>  | <code>SQL TINYINT</code>  | a small 8 bits signed/unsigned integer 
<code>SSmallInt</code>, <code>SSmallUInt</code>  | <code>SQL SMALLINT</code>  | a small 16 bits signed/unsigned integer 
<code>SMediumIInt</code>, <code>SMediumUInt</code>  | <code>SQL MEDIUMINT</code>  | a small 24 bits signed/unsigned integer 
<code>SBigInt</code>  | <code>SQL BIGINT</code>  | a 64 bits signed integer - typed as Float in Haxe 
<code>SSingle</code>  | <code>SQL FLOAT</code>  | a single precision float value 
<code>STinyText</code>  | <code>SQL TINYTEXT</code>  | a text up to 255 bytes 
<code>SSmallText</code>  | <code>SQL TEXT</code>  | a text up to 65KB 
<code>STimeStamp</code>  | <code>SQL TIMESTAMP</code>  | a 32-bits date timestamp 
<code>SSmallBinary</code>  | <code>SQL BLOB</code>  | up to 65 KB bytes 
<code>SLongBinary</code>  | <code>SQL LONGBLOB</code>  | up to 4GB bytes 
<code>SUId</code>  | <code>SQL INT UNSIGNED AUTO INCREMENT</code>  | same as <code>SUInt</code> but used as an unique ID with auto increment 
<code>SBigId</code>  | <code>SQL BIGINT AUTO INCREMENT</code>  | same as <code>SBigInt</code> but used as an unique ID with auto increment - compiled as `Float` in Haxe 
<code>SSmallFlags&lt;E&gt;</code>  |    | similar to <code>SFlags</code> except that the integer used to store the data is based on the number of flags allowed

### 10.14.6 SPOD Metadata

Metadata can be added to SPOD classes to declare additional information that will be used by SPOD.

##### Before each class field
 
 Metatag  |  Description 
 --- | ---
<code>@:skip</code>  | ignore this field, which will not be part of the database schema 
<code>@:relation</code>  | declare this field as a relation (see [relations](std-spod-relations.md)) 

##### Before the SPOD class
 
 Metatag  |  Description 
 --- | ---
<code>@:table("myTableName")</code>  | change the table name (by default it's the same as the class name) 
<code>@:id(field1,field2,...)</code>  | specify the primary key fields for this table.  
<code>@:index(field1,field2,...,[unique])</code>  | declare an index consisting of the specified classes fields - in that order. If the last field is unique then it means that's an unique index (each combination of fields values can only occur once) 

The following class does not have a unique id with auto increment, but a two-fields unique primary key:

```haxe 
@:id(uid, gid)
class UserGroup extends sys.db.Object {
    public var uid:SInt;
    public var gid:SInt;
}
```

### 10.14.7 SPOD Manager

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

### 10.14.8 SQL functions

###### SQL global functions
The following SQL global functions are possible in search queries:

##### functions
 
 Function  | Haxe Type  | SQL Type  |  Description 
 --- | --- | --- | ---
<code>now()</code>  | <code>SDateTime</code>  | <code>SQL NOW()</code>  | returns the current datetime 
<code>curDate()</code>  | <code>SDate</code>  | <code>SQL CURDATE()</code>  | returns the current date 
<code>date(v:SDateTime)</code>  | <code>SDate</code>  | <code>SQL DATE()</code>  | returns the date part of the <code>DateTime</code> 
<code>seconds(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v SECOND</code>  | returns the date interval in seconds  
<code>minutes(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v MINUTE</code>  | returns the date interval in minutes 
<code>hours(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v HOUR</code>  | returns the date interval in hours 
<code>days(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v DAY</code>  | returns the date interval in days 
<code>months(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v MONTH</code>  | returns the date interval in months 
<code>years(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v YEAR</code>  | returns the date interval in years 

###### SQL global operations
The following SQL global operators are possible in search queries:

##### operators
 
 Search operator  | SQL operator  |  Description 
 --- | --- | ---
<code>stringA.like(stringB)</code>  | SQL LIKE  | find if <code>stringB</code> is contained into <code>stringA</code> 
<code>name in ["a", "b", "c"]</code>   |   | Pass any <code>Iterable</code> to the in operator. An empty iterable will emit a false statement to prevent SQL errors when doing <code>IN ()</code>.

### 10.14.9 Search options

After the search query, specify some search options:

```haxe 
// retrieve the first 20 users ordered by ascending name
User.manager.search(true, {orderBy: name, limit: 20});
``` 

The following options are supported:

 * specify one of several order database fields and use a minus operation in front of the field to sort in descending order. For instance `{orderBy: [-name, id]}` will generate `SQL ORDER BY name DESC, id`
* specify which result range to obtain. Use Haxe variables and expressions in limit values, for instance `{ limit: [pos, length]}`
* force this search to use the specific index. For example to force a two-fields index use `{ forceIndex: [name, date]}`. The index name used in that case will be `TableName_name_date`

### 10.14.10 SPOD Dynamic search

To build own exact-values search criteria at runtime, use `Manager.dynamicSearch` that will build the SQL query based on the values you pass it. Please note that you can get runtime errors if your object contain fields that are not in the database table.

```haxe 
var query = {name: "John", phoneNumber: "+818123456"};
var users = User.manager.dynamicSearch(query);
```

### 10.14.11 SPOD Relation search

Search a given [relation](std-spod-relations.md) by using either the relation key or the relation property.

```haxe 
var user = User.manager.get(1);
var groups = UserGroup.manager.search($uid == user.id);

// same as:
var groups = UserGroup.manager.search($user == user);
``` 
The second case is more strictly typed since it does not only check that the key have the same type, and it also safer because it will use null id if the user value is null at runtime.

### 10.14.12 SPOD Relations

Declare relations between database classes by using the `@:relation` metadata.

```haxe 
class User extends sys.db.Object {
    public var id:SId;
    // ....
}
class Group extends sys.db.Object {
   public var id:SId;
   // ...
}

@:id(gid, uid)
class UserGroup extends sys.db.Object {
    @:relation(uid) public var user:User;
    @:relation(gid) public var group:Group;
}
``` 

The first time the user field from an UserGroup instance gets read by SPOD Macros, SPOD will fetch the User instance corresponding to the current uid value and cache it. When the user field gets set, it will modify the uid value as the same time.

###### Locking
When using transactions, the default behavior for relations is that they are not locked. Lock the row (`SQL SELECT...FOR UPDATE`) by adding the lock keyword after the relation key:

```haxe 
@:relation(uid, lock) public var user:User;
``` 

###### Cascading

Relations can be strongly enforced by using `CONSTRAINT`/`FOREIGN KEY` with MySQL/InnoDB. This way when an User instance is deleted, all the corresponding UserGroup for the given user will be deleted as well. However if the relation field can be nullable, the value will be set to `NULL`. To enforce cascading for nullable-field relations, add the cascade keyword after the relation key.

```haxe 
@:relation(uid,cascade) var user:Null<User>;
```

### 10.14.13 SPOD Serialized Data

##### since Haxe Haxe 2.11

In order to store arbitrary serialized data in a SPOD object, use the `SData` type. For example:

```haxe 
import sys.db.Types
enum PhoneKind {
    AtHome;
    AtWork;
    Mobile;
}
class User extends sys.db.Object {
    public var id : SId;
    ...
    public var phones : SData<Array<{kind:PhoneKind, number:String}>>;
}
``` 

* When the phones field is accessed for reading (the first time only), it is unserialized. By default the data is stored as an Haxe-serialized String, but is possible to override the `doSerialize` and `doUnserialize` methods of the Manager to have a specific serialization for a specific table or field.
* When the phones field has been either read or written, a flag will be set to remember that potential changes were made.
* When the SPOD object is either inserted or updated, the modified data is serialized and eventually sent to the database if some actual change have been done.

As a consequence, pushing data into the phones `Array` or directly modifying the phone number will be noticed by the SPOD engine.

The SQL data type for `SData` is a binary blob, in order to allow any kind of serialization (text or binary), so the actual runtime value of the phones field is a Bytes. It will however only be accessible by reflection, since SPOD is changing the phones field into a property.

###### Accessing the SPOD Infos
Get the database schema by calling the `Manager.dbInfos()` method. It will return a `sys.db.SpodInfos` structure.

---

Previous section: [Implementation details](std-remoting-implementation-details.md)

Next section: [Haxelib](haxelib.md)