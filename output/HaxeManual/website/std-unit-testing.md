## 10.14 Unit testing

The Haxe Standard Library provides basic unit testing classes from the `haxe.unit` package. 

###### Creating new test cases

First, create a new class extending `haxe.unit.TestCase` and add own test methods. Every test method name must start with "`test`".

```haxe
class MyTestCase extends haxe.unit.TestCase {
  public function testBasic() {
    assertEquals("A", "A");
  }
}

```

###### Running unit tests
To run the test, an instance of `haxe.unit.TestRunner` has to be created. Add the `TestCase` using the `add` method and call `run` to start the test.

```haxe
class Main {
  static function main() {
    var r = new haxe.unit.TestRunner();
    r.add(new MyTestCase());
    // add other TestCases here
    
    // finally, run the tests
    r.run();
  }
}

```

The result of the test looks like this:
```haxe 
Class: MyTestCase
.
OK 1 tests, 0 failed, 1 success
``` 

###### Test functions
The `haxe.unit.TestCase` class comes with three test functions.

* `assertEquals(a, b)` Succeeds if `a` and `b` are equal, where `a` is value tested and `b` is the expected value.
* `assertTrue(a)` Succeeds if `a` is `true`
* `assertFalse(a)` Succeeds if `a` is `false`

###### Setup and tear down

To run code before or after the test, override the functions `setup` and `tearDown` in the `TestCase`. 

* `setup` is called before each test runs.
* `tearDown` is called once after all tests are run.

```haxe
class MyTestCase extends haxe.unit.TestCase {
  var value:String;

  override public function setup() {
    value = "foo";
  }

  public function testSetup() {
    assertEquals("foo", value);
  }
}

```

###### Comparing Complex Objects

With complex objects it can be difficult to generate expected values to compare to the actual ones. It can also be a problem that `assertEquals` doesn't do a deep comparison. One way around these issues is to use a string as the expected value and compare it to the actual value converted to a string using `Std.string`. Below is a trivial example using an array.

```haxe 
public function testArray() {
  var actual = [1,2,3];
  assertEquals("[1, 2, 3]", Std.string(actual));
}
```

---

Previous section: [Implementation details](std-remoting-implementation-details.md)

Next section: [Haxelib](haxelib.md)