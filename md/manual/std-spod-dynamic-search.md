## 10.14.10 SPOD Dynamic search

To build own exact-values search criteria at runtime, use `Manager.dynamicSearch` that will build the SQL query based on the values you pass it. Please note that you can get runtime errors if your object contain fields that are not in the database table.

```haxe 
var query = {name: "John", phoneNumber: "+818123456"};
var users = User.manager.dynamicSearch(query);
```

---

Previous section: [Search options](std-spod-search-options.md)

Next section: [SPOD Relation search](std-spod-relation-search.md)