## 10.13.1 Remoting Connection

In order to use remoting, there must be a connection established. There are two kinds of Haxe Remoting connections: 

* `haxe.remoting.Connection` is used for **synchronous connections**, where the results can be directly obtained when calling a method. 
* `haxe.remoting.AsyncConnection` is used for **asynchronous connections**, where the results are events that will happen later in the execution process.

###### Start a connection
There are some target-specific constructors with different purposes that can be used to set up a connection:

* All targets:

    * `HttpAsyncConnection.urlConnect(url:String)`  Returns an asynchronous connection to the given URL which should link to a Haxe server application. 
* Flash:

    * `ExternalConnection.jsConnect(name:String, ctx:Context)`  Allows a connection to the local JavaScript Haxe code. The JS Haxe code must be compiled with the class ExternalConnection included. This only works with Flash Player 8 and higher.
    * `AMFConnection.urlConnect(url:String)` and `AMFConnection.connect( cnx : NetConnection )`  Allows a connection to an [AMF Remoting server](http://en.wikipedia.org/wiki/Action_Message_Format) such as [Flash Media Server](http://www.adobe.com/products/adobe-media-server-family.html) or [AMFPHP](http://www.silexlabs.org/amfphp/).
    * `SocketConnection.create(sock:flash.XMLSocket)`  Allows remoting communications over an `XMLSocket`
    * `LocalConnection.connect(name:String)`  Allows remoting communications over a [Flash LocalConnection](http://api.haxe.org/haxe/remoting/LocalConnection.html)
* Javascript:

    * `ExternalConnection.flashConnect(name:String, obj:String, ctx:Context)`  Allows a connection to a given Flash Object. The Haxe Flash content must be loaded and it must include the `haxe.remoting.Connection` class. This only works with Flash 8 and higher. 
* Neko:

    * `HttpConnection.urlConnect(url:String)`  Will work like the asynchronous version but in synchronous mode.
    * `SocketConnection.create(...)`  Allows real-time communications with a Flash client which is using an `XMLSocket` to connect to the server.

###### Remoting context

Before communicating between platforms, a remoting context has to be defined. This is a shared API that can be called on the connection at the client code.

This server code example creates and shares an API:
```haxe
class Server {
	function new() { }
	function foo(x, y) { return x + y; }

	static function main() {
		var ctx = new haxe.remoting.Context();
		ctx.addObject("Server", new Server());

		if(haxe.remoting.HttpConnection.handleRequest(ctx))
		{
			return;
		}

		// handle normal request
		trace("This is a remoting server !");
	} 
}
```

###### Using the connection

Using a connection is pretty convenient. Once the connection is obtained, use classic dot-access to evaluate a path and then use `call()` to call the method in the remoting context and get the result.
The asynchronous connection takes an additional function parameter that will be called when the result is available.

This client code example connects to the server remoting context and calls a function `foo()` on its API.
```haxe
class Client {
  static function main() {
    var cnx = haxe.remoting.HttpAsyncConnection.urlConnect("http://localhost/");
    cnx.setErrorHandler( function(err) trace('Error: $err'); } );
    cnx.Server.foo.call([1,2], function(data) trace('Result: $data'););
  }
}
```

To make this work for the Neko target, setup a Neko Web Server, point the url in the Client to `"http://localhost2000/remoting.n"` and compile the Server using `-main Server -neko remoting.n`.

###### Error handling

* When an error occurs in a asynchronous call, the error handler is called as seen in the example above.
* When an error occurs in a synchronous call, an exception is raised on the caller-side as if we were calling a local method.

###### Data serialization

Haxe Remoting can send a lot of different kinds of data. See [Serialization](std-serialization.md).

---

Previous section: [Remoting](std-remoting.md)

Next section: [Implementation details](std-remoting-implementation-details.md)