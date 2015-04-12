## 12.2.2 Embedding resources

Embedding resources is different in Haxe compared to Actionscript 3. Instead of using `[embed]` (AS3-metatag) use [Flash specific compiler metatags](target-flash-metatags.md) like `@:bitmap`, `@:font`, `@:sound` or `@:file`.

```haxe
import flash.Lib;
import flash.display.BitmapData;
import flash.display.Bitmap;

class Main {
  public static function main() {
    var img = new Bitmap( new MyBitmapData(0, 0) );
    Lib.current.addChild(img);
  }
}

@:bitmap("relative/path/to/myfile.png") 
class MyBitmapData extends BitmapData { }
```

---

Previous section: [Getting started with Haxe/Flash](target-flash-getting-started.md)

Next section: [Using external Flash libraries](target-flash-external-libraries.md)