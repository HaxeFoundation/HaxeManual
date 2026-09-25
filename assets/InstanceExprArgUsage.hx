class Test {
	static function main() {
		final factLogger = new Logger("Fact");
		final lieLogger = new Logger("Lie");
		
		final theory1 = {statement: "Haxe is great!", conclusion: true};
		final theory2 = {statement: "7 > 9", conclusion: false};
		
		(theory1.conclusion ? factLogger : lieLogger).logExpr(theory1.statement);
		(theory2.conclusion ? factLogger : lieLogger).logExpr(theory2.statement);
	}
}
