## 13.6 Source Maps in JavaScript

In the generated JavaScript the last line will have a reference to the source map that looks like this:

```haxe
//# sourceMappingURL=Main.js.map
```

To include the hx sources as part of the JS source map, compile with `-D source-map-content`.

Make sure to enable 'JS source maps' in the browser developer tool settings. 

* [Chrome source-maps](https://developers.google.com/web/tools/chrome-devtools/debug/readability/source-maps)
* [Firefox source-maps](https://developer.mozilla.org/en-US/docs/Tools/Debugger/How_to/Use_a_source_map)
* [Safari source-maps](https://developer.apple.com/library/safari/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/ResourcesandtheDOM/ResourcesandtheDOM.html#//apple_ref/doc/uid/TP40007874-CH3-SW2)

---

Previous section: [Source Maps](debugging-source-map.md)

Next section: [Source Maps in Php7](debugging-sourcemap-php7.md)