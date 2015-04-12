## 10.14.12 SPOD Relations

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

---

Previous section: [SPOD Relation search](std-spod-relation-search.md)

Next section: [SPOD Serialized Data](std-spod-serialized-data.md)