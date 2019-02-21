## 12.1.2 ECMAScript 6 class generation

##### since Haxe 4.0

Starting with Haxe 4.0, Haxe can generate [ES6 class definitions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes) instead of classic function + prototype combination. This might be required when using third-party ES6 libraries, because native ES6 classes cannot be extended using the old method.

To enable ES6 generation mode, simply add `-D js-es=6` to the compiler arguments.

##### Accessing `this` before calling `super` constructors

One of significant differences between Haxe classes and ES6 classes reveals itself when inheritance is used. ES6 does not allow accessing `this` in any way before calling `super()` within a child class constructor, while Haxe allows calling `super()` at any place in the constructor.

Even when we don't explicitly access `this` before `super()` in Haxe code, it can still happen when a class has fields with initializer values.

Let's take a look at the following example:

```haxe
class Base {
  function new() {
    init();
  }
  function init() {
    trace("base init");
  }
}

class Child extends Base {
  var field = "hello";

  override function init() {
    trace(field);
  }
}
```

Haxe guarantees that the fields will be initialized before any constructor code is executed, and because accessing `this` (for setting the field value) before the `super()` call is not allowed in ES6, Haxe has to work this limitation around by transforming constructors like in the following example:

```js
class Base {
  constructor() {
    if(Base._hx_skip_constructor) {
      return;
    }
    this._hx_constructor();
  }
  _hx_constructor() {
    this.init();
  }
  init() {
    console.log("src/Main.hx:6:","base init");
  }
}
class Child extends Base {
  constructor() {
    Base._hx_skip_constructor = true;
    super();
    Base._hx_skip_constructor = false;
    this._hx_constructor();
  }
  _hx_constructor() {
    this.field = "hello";
    super._hx_constructor();
  }
  init() {
    console.log("src/Main.hx:14:",this.field);
  }
}
Base._hx_skip_constructor = false;
```

Note, that Haxe does it best to be smart and only generate this workaround code when it's required.

##### When extending extern classes with constructors

One important limitation that one has to keep in mind is that it's obviously not possible for Haxe to do these transformations on [extern](https://haxe.org/manual/lf-externs.html) class implementations. That's why it is impossible to access `this` before calling `super()` at all when extending a native `extern` class. Haxe will detect these cases and emit a compile error pointing to first expression or field declaration that requires `this` access.

For example:

```haxe
extern class Base {
  function new();
}

class Child extends Base {
  var field = "hello";
}
```

Trying to compile this will fail with the following error: `Main.hx:6: characters 3-23 : Must call super() constructor before accessing this in classes derived from an extern class with constructor`

However, if the parent `extern` class would not have a constructor defined, this code would compile, because the compiler knows that it is safe to call a parent's empty `super()` constructor before anything else.

So, the following code:

```haxe
extern class Base {
}

class Child extends Base {
  var field = "hello";
}
```

Will generate the expected ES6 output:

```js
class Child extends Base {
  constructor() {
    super();
    this.field = "hello";
  }
}
```

---

Previous section: [Getting started with Haxe/JavaScript](target-javascript-getting-started.md)

Next section: [Using external JavaScript libraries](target-javascript-external-libraries.md)