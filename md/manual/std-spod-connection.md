## 10.14.3 Making connection

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

---

Previous section: [Initialization](std-spod-initialization.md)

Next section: [Creating tables](std-spod-tables.md)