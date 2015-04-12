## 10.13.2 Implementation details

###### Javascript security specifics

The html-page wrapping the js client must be served from the same domain as the one where the server is running. The same-origin policy restricts how a document or script loaded from one origin can interact with a resource from another origin. The same-origin policy is used as a means to prevent some of the cross-site request forgery attacks.

To use the remoting across domain boundaries, CORS (cross-origin resource sharing) needs to be enabled by defining the header `X-Haxe-Remoting` in the `.htaccess`:

```haxe 
# Enable CORS
Header set Access-Control-Allow-Origin "*"
Header set Access-Control-Allow-Methods: "GET,POST,OPTIONS,DELETE,PUT"
Header set Access-Control-Allow-Headers: X-Haxe-Remoting
``` 

See [same-origin policy](http://en.wikipedia.org/wiki/Same-origin_policy) for more information on this topic.

Also note that this means that the page can't be served directly from the file system `"file:///C:/example/path/index.html"`.

###### Flash security specifics

When Flash accesses a server from a different domain, set up a `crossdomain.xml` file on the server, enabling the `X-Haxe` headers.

```haxe 
<cross-domain-policy>
	<allow-access-from domain="*"/> <!-- or the appropriate domains -->
	<allow-http-request-headers-from domain="*" headers="X-Haxe*"/>
</cross-domain-policy>
``` 

###### Arguments types are not ensured

There is no guarantee of any kind that the arguments types will be respected when a method is called using remoting. 
That means even if the arguments of function `foo` are typed to `Int`, the client will still be able to use strings while calling the method. 
This can lead to security issues in some cases. When in doubt, check the argument type when the function is called by using the `Std.is` method.

---

Previous section: [Remoting Connection](std-remoting-connection.md)

Next section: [Unit testing](std-unit-testing.md)