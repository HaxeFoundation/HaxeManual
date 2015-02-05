import php.Lib;

class Main {
	static function main() {
		var title = 'Haxe is great!';
		var body = 'Hello world';
		var html = '
			<!DOCTYPE html>
			<html>
				<head>
					<title>$title</title>
				</head>
				<body>
					<h1>$title</h1>
					<p>$body</p>
				</body>
			</html>
		';
		
		Lib.println(html);
	}
}
