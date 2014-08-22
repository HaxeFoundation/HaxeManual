## 11.2.1 Versioning

Haxelib uses a simplified version of [SemVer](http://semver.org/). The basic format is this:

```haxe
major.minor.patch
```

These are the basic rules:

* Major versions are incremented when you break backwards compatibility - so old code will not work with the new version of the library.
* Minor versions are incremented when new features are added.
* Patch versions are for small fixes that do not change the public API, so no existing code should break.
* When a minor version increments, the patch number is reset to 0. When a major version increments, both the minor and patch are reset to 0.

Examples:

* "0.0.1": A first release.  Anything with a "0" for the major version is subject to change in the next release - no promises about API stability!
* "0.1.0": Added a new feature!   Increment the minor version, reset the patch version
* "0.1.1": Realised the new feature was broken.  Fixed it now, so increment the patch version
* "1.0.0": New major version, so increment the major version, reset the minor and patch versions.   You promise your users not to break this API until you bump to 2.0.0
* "1.0.1": A minor fix
* "1.1.0": A new feature
* "1.2.0": Another new feature
* "2.0.0": A new version, which might break compatibility with 1.0.  Users are to upgrade cautiously.

If this release is a preview (Alpha, Beta or Release Candidate), you can also include that, with an optional release number:

```haxe
major.minor.patch-(alpha/beta/rc).release
```

Examples:

* "1.0.0-alpha": The alpha of 1.0.0 - use with care, things are changing!
* "1.0.0-alpha.2": The 2nd alpha
* "1.0.0-beta": Beta - things are settling down, but still subject to change.
* "1.0.0-rc.1": The 1st release candidate for 1.0.0 - you shouldn't be adding any more features now
* "1.0.0-rc.2": The 2nd release candidate for 1.0.0
* "1.0.0": The final release!

---

Previous section: [haxelib.json](haxelib-json.md)

Next section: [Dependencies](haxelib-json-dependencies.md)