## 10.4.4 Extensions

It is common to see [Static Extension](lf-static-extension.md) used with the math library.  This code shows a simple example:  
```haxe
class MathStaticExtension {
	/** Converts an angle in radians to degrees. */
	inline public static function toDegrees (radians :Float) :Float
	{
		return radians * 180/Math.PI;
	}
}


```
```haxe
using MathStaticExtension;
class TestMath{
	public static function main(){
		var ang = 1/2*Math.PI;
		trace(ang.toDegrees()); //90
	}
}





```

---

Previous section: [Integer Math](std-math-integer-math.md)

Next section: [Json](std-Json.md)