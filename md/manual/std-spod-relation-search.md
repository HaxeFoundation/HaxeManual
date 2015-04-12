## 10.14.11 SPOD Relation search

Search a given [relation](std-spod-relations.md) by using either the relation key or the relation property.

```haxe 
var user = User.manager.get(1);
var groups = UserGroup.manager.search($uid == user.id);

// same as:
var groups = UserGroup.manager.search($user == user);
``` 
The second case is more strictly typed since it does not only check that the key have the same type, and it also safer because it will use null id if the user value is null at runtime.

---

Previous section: [SPOD Dynamic search](std-spod-dynamic-search.md)

Next section: [SPOD Relations](std-spod-relations.md)