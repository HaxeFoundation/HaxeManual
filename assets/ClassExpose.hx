@:expose
class MyClass {
	var name:String;
	function new(name:String) {
		this.name = name;
	}
	public function foo() {
		return 'Greetings from $name!';
	}
}