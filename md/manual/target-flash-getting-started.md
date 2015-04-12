## 12.2.1 Getting started with Haxe/Flash

Developing Flash applications is really easy with Haxe. Let's look at our first code sample.
This is a basic example showing most of the toolchain. 

Create a new folder and save this class as `Main.hx`.

```haxe
import flash.Lib;
import flash.display.Shape;
class Main {
    static function main() {
        var stage = Lib.current.stage;
        
        // create a center aligned rounded gray square
        var shape = new Shape();
        shape.graphics.beginFill(0x333333);
		shape.graphics.drawRoundRect(0, 0, 100, 100, 10);
		shape.x = (stage.stageWidth - 100) / 2;
		shape.y = (stage.stageHeight - 100) / 2;

		stage.addChild(shape);
    }    
}
```

To compile this, either run the following from the command line:

```haxe
haxe -swf main-flash.swf -main Main -swf-version 15 -swf-header 960:640:60:f68712
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml-file should be in the same directory as the example class.

```haxe
-swf main-flash.swf
-main Main
-swf-version 15
-swf-header 960:640:60:f68712
```

The output will be a main-flash.swf with size 960x640 pixels at 60 FPS with an orange background color and a gray square in the center.

###### Display the Flash

Run the SWF standalone using the [Standalone Debugger FlashPlayer](https://www.adobe.com/support/flashplayer/downloads.html). 

To display the output in a browser using the Flash-plugin, create an HTML-document called `index.html` and open it.

```haxe
<!DOCTYPE html>
<html>
	<body>
		<embed src="main-flash.swf" width="960" height="640">
	</body>
</html>
```

###### More information

* [Haxe Flash API docs](http://api.haxe.org/flash/)
* [Adobe Livedocs](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/)

---

Previous section: [Flash](target-flash.md)

Next section: [Embedding resources](target-flash-resources.md)