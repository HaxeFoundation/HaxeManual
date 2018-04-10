## 7.1 HXML

[Compiler arguments](compiler-usage.md) can be stored in a .hxml file and can be executed with `haxe <file.hxml>`.
In hxml it is possible to use newlines and comments which makes it easier to maintain Haxe build configurations.
It is possible to supply more arguments after the hxml file, e.g. `haxe build.hxml -debug`.

**Example:**

This example has a configuration which compiles the class file `website.HomePage.hx` to JavaScript into a file called `bin/homepage.js`, which is located in the `src` class path. And uses full dead code elimination.

```hxml
-cp src
-dce full
-js bin/homepage.js
-main website.HomePage
```

##### Multiple build compilations

Hxml configurations allow multiple compilation using these arguments:

* `--next` Separate several Haxe compilations.
* `--each` Append preceding parameters to all haxe compilations separated by `--next`. This reduces the repeating params.

**Example:**

This example has a configuration which compiles three different classes into their own JavaScript files. Each build uses `src` as class path and uses full dead code elimination.

```hxml
-cp src
-dce full

--each

-js bin/homepage.js
-main website.HomePage

--next  

-js bin/gallery.js
-main website.GalleryPage

--next  

-js bin/contact.js
-main website.ContactPage
```

##### Comments inside hxml

Inside .hxml files use a hash (i.e. `#`) to comment out the rest of the line. 

**Calling build configurations inside HXML:**

It is possible to create a configuration that looks like this:

```hxml
build-server.hxml  
--next  
build-website.hxml  
--next  
build-game.hxml
```

---

Previous section: [Compiler Usage](compiler-usage.md)

Next section: [Global Compiler Flags](compiler-usage-flags.md)