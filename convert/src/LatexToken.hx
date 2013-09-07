enum LatexToken {
	TText(s:String);
	TCommand(cmd:LatexCommand);
	TBegin(s:String);
	TEnd(s:String);
	TCustomCommand(cmd:String);
	TBrOpen;
	TBrClose;
	TBkOpen;
	TBkClose;
	TNewline;
	TEof;
}