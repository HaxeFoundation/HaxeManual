class Test {
	static function main() {
		var users:haxe.DynamicAccess<User> = {
			John: { surname: "Smith", age: 24 },
			Patti: { surname: "Mayonaise", age: 16 }
		};
		
		// Get user John, throw him a brithday
		var john = users.get("John");
		john.age++;
		
		trace('John ${john.surname} turned ${john.age}');
		
		// Add new user
		users.set("Mark", { surname: "McCartney", age:30 });
		
		// Whether the structure contains a specified key
		trace(users.exists("Mark")); // true
		
		// Output all users
		for (name => data in users) {
			trace('$name ${data.surname} is ${data.age} years old');
		}
	}
}

typedef User = { surname:String, age:Int };
