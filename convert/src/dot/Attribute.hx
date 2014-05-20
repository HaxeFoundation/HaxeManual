package dot;

enum ArrowType {
	Normal;
	Dot;
	ODot;
	None;
	Empty;
	Diamond;
	EDiamond;
	Box;
	Open;
	Vee;
	Inv;
	InvDot;
	InvODot;
	Tee;
	InvEmpty;
	ODiamond;
	Crow;
	OBox;
	HalfOpen;
	Circle;
}

enum ClusterMode {
	Local;
	Global;
	None;
}

enum CompassPoint {
	N;
	NE;
	E;
	SE;
	S;
	SW;
	W;
	NW;
	C;
	_;
}

enum DirType {
	Forward;
	Back;
	Both;
	None;
}

enum ImageScale {
	False;
	True;
	Width;
	Height;
	Both;
}

enum OutputMode {
	BreadhFirst;
	NodesFirst;
	EdgesFirst;
}

enum PackMode {
	Node;
	Clust;
	Graph;
	// TODO
}

typedef Point = {
	x: Float,
	y: Float
}

enum RankDir {
	Tb;
	Lr;
	Bt;
	Rl;
}

enum RankType {
	Same;
	Min;
	Source;
	Max;
	Sink;
}

typedef Rectangle = {
	llx: Float,
	lly: Float,
	urx: Float,
	ury: Float
}

enum Shape {
	Box;
	Polygon;
	Ellipse;
	Oval;
	Circle;
	Point;
	Egg;
	Triangle;
	Plaintext;
	Diamond;
	Trapezium;
	Parallelogram;
	House;
	Pentagon;
	Hexagon;
	Septagon;
	Octagon;
	Doublecircle;
	Doubleoctagon;
	Tripleoctagon;
	Invtriangle;
	Invtrapezium;
	Invhouse;
	Mdiamond;
	Msquare;
	Mcircle;
	Rect;
	Rectangle;
	Square;
	Star;
	None;
	Underline;
	Note;
	Tab;
	Folder;
	Box3d;
	Component;
	Promoter;
	Cds;
	Terminator;
	Utr;
	Primersite;
	Restrictionsite;
	Fivepoverhang;
	Threepoverhang;
	Noverhang;
	Assembly;
	Signature;
	Insulator;
	Ribosite;
	Rnastab;
	Proteasesite;
	Proteinstab;
	Rpromoter;
	Rarrow;
	Larrow;
	Lpromoter;
}

enum SmoothType {
	None;
	Avg_dist;
	Graph_dist;
	Power_dist;
	Rng;
	Spring;
	Triangle;
}

enum Style {
	Dashed;
	Dotted;
	Solid;
	Invis;
	Bold;
	Tapered;
	Filled;
	Striped;
	Wedged;
	Diagonals;
	Rounded;
}

enum Attribute {
	Area(f:Float);
	ArrowHead(at:ArrowType);
	ArrowSize(f:Float);
	ArrowTail(at:ArrowType);
	BB(rect:Rectangle);
	BGColor(c:Color);
	Center(b:Bool);
	Charset(s:String);
	ClusterRank(cm:ClusterMode);
	Color(cl:Array<Color>);
	ColorScheme(s:String);
	Comment(s:String);
	Compound(b:Bool);
	Concentrate(b:Bool);
	Constraint(b:Bool);
	Decorate(b:Bool);
	DefaultDist(f:Float);
	Dim(i:Int);
	Dimen(i:Int);
	Dir(dt:DirType);
	DirEdgeConstraints; // TODO
	Distortion(f:Float);
	DPI(f:Float);
	EdgeUrl(s:String);
	EdgeHref(s:String);
	EdgeTarget(s:String);
	EdgeTooltip(s:String);
	Epsilon(f:Float);
	ESep(?f:Float, p:Point);
	FillColor(c:Color);
	FixedSize(b:Bool);
	FontColor(c:Color);
	FontName(s:String);
	FontNames(s:String);
	FontPath(s:String);
	FontSize(f:Float);
	ForceLabels(b:Bool);
	GradientAngle(i:Int);
	Group(s:String);
	HeadUrl(s:String);
	Head_lp(p:Point);
	HeadClip(b:Bool);
	HeadHref(s:String);
	HeadLabel(s:String);
	HeadPort(s:String, ?cp:CompassPoint);
	HeadTarget(s:String);
	HeadTooltip(s:String);
	Height(f:Float);
	Href(s:String);
	Id(s:String);
	Image(s:String);
	ImagePath(s:String);
	ImageScale(is:ImageScale);
	InputScale(f:Float);
	Label(s:String);
	LabelUrl(s:String);
	LabelScheme(i:Int);
	LabelAngle(f:Float);
	LabelDistance(f:Float);
	LabelFloat(b:Bool);
	LabelFontColor(c:Color);
	LabelFontName(s:String);
	LabelFontSize(f:Float);
	LabelHref(s:String);
	LabelJust(s:String);
	LabelLoc(s:String);
	LabelTarget(s:String);
	LabelTooltip(s:String);
	Landscape(b:Bool);
	Layer; // TODO
	LayerListSep(s:String);
	Layers; // TODO
	LayerSelect; // TODO
	LayerSep(s:String);
	Layout(s:String);
	Len(f:Float);
	Levels(i:Int);
	LevelsGap(f:Float);
	LHead(s:String);
	LHeight(f:Float);
	Lp(p:Point);
	LTail(s:String);
	LWidth(f:Float);
	Margin; // TODO
	MaxIter(i:Int);
	McLimit(f:Float);
	MInDist(f:Float);
	MinLen(i:Int);
	Mode(s:String);
	Model(s:String);
	Mosek(b:Bool);
	NoDesep(f:Float);
	NoJustify(b:Bool);
	Normalize(f:Float);
	NsLimit(f:Float);
	Ordering(s:String);
	Orientation(s:String);
	OutputOrder(om:OutputMode);
	Overlap; // TODO
	Overlap_Scaling(f:Float);
	Overlap_Shrink(b:Bool);
	Pack; // TODO
	Packmode(pm:PackMode);
	Pad; // TODO
	Page; // TODO
	PageDir; // TODO
	PenColor(c:Color);
	PenWidth(f:Float);
	Peripheries(i:Int);
	Pin(b:Bool);
	Pos; // TODO
	Quadtree; // TODO
	Quantum(f:Float);
	Rank(rt:RankType);
	RankDir(rd:RankDir);
	RankSep(fl:Array<Float>);
	Ratio; // TODO
	Rects(rect:Rectangle);
	Regular(b:Bool);
	Remincross(b:Bool);
	RepulsiveForce(f:Float);
	Resolution(f:Float);
	Root; // TODO
	Rotate(i:Int);
	Rotation(f:Float);
	SameHead(s:String);
	SameTail(s:String);
	SamplePoint(o:Int);
	Scale; // TODO
	SearchSize(i:Int);
	Sep; // TODO
	Shape(sh:Shape);
	Shapefile(s:String);
	Showboxes(i:Int);
	Sides(i:Int);
	Size; // TODO
	Skew(f:Float);
	Smoothing(st:SmoothType);
	Sortv(i:Int);
	Splines; // TODO
	Start; // TODO
	Style(st:Style);
	Stylesheet(s:String);
	TailUrl(s:String);
	Tail_lp(p:Point);
	TailClip(b:Bool);
	TailHref(s:String);
	TailLabel(s:String);
	TailPort; // TODO
	TailTarget(s:String);
	TailTooltip(s:String);
	Target(s:String);
	Tooltip(s:String);
	Truecolor(b:Bool);
	Vertices(pl:Array<Point>);
	Viewport; // TODO
	Voro_margin(f:Float);
	Weight(f:Float);
	Width(f:Float);
	XDotVersion(s:String);
	XLabel(s:String);
	XLp(p:Point);
	Z(f:Float);
}