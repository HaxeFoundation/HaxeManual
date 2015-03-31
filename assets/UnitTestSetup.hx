class MyTestCase extends haxe.unit.TestCase {
  var value:String;

  override public function setup() {
    value = "foo";
  }

  public function testSetup() {
    assertEquals("foo", value);
  }
}
