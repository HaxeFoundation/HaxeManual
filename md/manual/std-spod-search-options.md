## 10.14.9 Search options

After the search query, specify some search options:

```haxe 
// retrieve the first 20 users ordered by ascending name
User.manager.search(true, {orderBy: name, limit: 20});
``` 

The following options are supported:

 * specify one of several order database fields and use a minus operation in front of the field to sort in descending order. For instance `{orderBy: [-name, id]}` will generate `SQL ORDER BY name DESC, id`
* specify which result range to obtain. Use Haxe variables and expressions in limit values, for instance `{ limit: [pos, length]}`
* force this search to use the specific index. For example to force a two-fields index use `{ forceIndex: [name, date]}`. The index name used in that case will be `TableName_name_date`

---

Previous section: [SQL functions](std-spod-sql.md)

Next section: [SPOD Dynamic search](std-spod-dynamic-search.md)