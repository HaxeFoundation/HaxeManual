enum LatexToken {
	TText(s:String);
	TCommand(cmd:LatexCommand);
	TBegin(s:String);
	TEnd(s:String);
	TCustomCommand(cmd:String);
	TCustomEnvironment(cmd:String, s:String, handler:String->String);
	TBrOpen;
	TBrClose;
	TBkOpen;
	TBkClose;
	TNewline;
	TDoubleBackslash;
	TTab;
	TDollar;
	TDollarLiteral;
	TAmp;
	TEof;
}
