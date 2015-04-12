## 10.14.4 Creating tables

Calling `sys.db.TableCreate.create` will execute a `CREATE TABLE SQL` request based on the SPOD infos.

```haxe 
if (!sys.db.TableCreate.exists(User.manager)) {
    sys.db.TableCreate.create(User.manager);
}
``` 

Please note that currently `TableCreate` will not create the index or initialize the relations of your table.

---

Previous section: [Making connection](std-spod-connection.md)

Next section: [SPOD Supported types](std-spod-supported-types.md)