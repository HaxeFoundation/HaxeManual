## 10.14.2 Initialization

There are two static methods that might be needed to call before/after using SPOD:

* `sys.db.Manager.initialize()` will initialize the created managers. Make sure to call it at least once before using SPOD.
* `sys.db.Manager.cleanup()` will cleanup the temporary object cache. This can be done if you are using server module caching to free memory or after a rollback to make sure that we don't use the cached object version.

---

Previous section: [SPOD Objects](std-spod-objects.md)

Next section: [Making connection](std-spod-connection.md)