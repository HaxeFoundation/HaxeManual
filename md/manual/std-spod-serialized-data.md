## 10.14.13 SPOD Serialized Data

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

Previous section: [SPOD Relations](std-spod-relations.md)

Next section: [Haxelib](haxelib.md)