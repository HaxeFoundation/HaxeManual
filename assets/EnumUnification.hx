import Color;

class EnumUnification {
	static public function main() {
		var ec:EnumValue = Red; // valid
		var en:Enum<Color> = Color; // valid
		//var x:Enum<Color> = Red; // Compile Error: Color should be Enum<Color>
	}
}
