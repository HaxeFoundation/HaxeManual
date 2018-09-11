## 12.10.3 Version flags

The Lua target enables the following define flags for the Haxe complier:

* `-D lua_ver` Enable special features for a specific Lua version. Currently, this flag will enable extern methods that are specific to certain versions (e.g. table.pack in Lua > 5.2).
* `-D luajit` Enable special features for LuaJIT.  Currently this flag will enable the `jit` and `ffi` module namespaces.

---

Previous section: [Using external Lua libraries](target-lua-external-libraries.md)

Next section: [Multireturns](target-lua-multireturns.md)