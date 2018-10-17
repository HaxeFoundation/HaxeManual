## 12.10.1 Getting started with Haxe/Lua

To get started with Haxe for Lua, it's necessary to pick a Lua version and install
dependencies.  All versions of Lua are supported, but may require different
libraries.  Lua 5.1, 5.2, 5.3, and LuaJIT 2.0 and 2.1 (beta) are supported.

Lua is a very lightweight language that ships with a much smaller  feature set
than Haxe.  In some cases (e.g. regex), it's necessary to install supplementary
libraries that are used to support basic Haxe functionality.

In order to cover all dependencies, it is recommended to install and use
[LuaRocks](https://github.com/luarocks/luarocks/wiki/Download).  However,
if you do not utilize relevant behavior (e.g. regex) on a given platform,
or if you are using an embedded Lua client, then it is not necessary to
install any packages for basic language functionality.

With LuaRocks, install the haxe dependency package:

```sh
luarocks install haxe-deps
```

When developing for multiple Lua versions, it is recommended to use
the Python package [hererocks](https://github.com/mpeterv/hererocks).

With Lua installed, it is possible to write a simple command line application.

Create a new folder, and save this class as `Main.hx`.

```haxe
class Main {
    static function main() {
        trace("hello world");
    }
}
```

To compile, run the following:
```hxml
haxe -lua out.lua -main Main
```

##### More information

* [Lua Homepage](https://www.lua.org/)
* [LuaJIT Homepage](http://luajit.org/)

---

Previous section: [Lua](target-lua.md)

Next section: [Using external Lua libraries](target-lua-external-libraries.md)
