package dot;

class Node {
	public var name:String;
	public var attrs:Array<Attribute>;
	var graph:Graph;

	@:allow(dot.Graph)
	function new(graph:Graph, name:String, attrs:Array<Attribute>) {
		this.graph = graph;
		this.name = name;
		this.attrs = attrs;
	}

	public function connect(to:Node, attrs:Array<Attribute>) {
		graph.edge(this, to, attrs);
	}
}