`@:abi` |  | Function ABI/calling convention. | cpp
`@:abstract` |  | Sets the underlying class implementation as `abstract`. | java, cs
`@:access` | &lt;Target path> | Forces private access to package, type or field. See [lf-access-control](lf-access-control). | all
`@:allow` | &lt;Target path> | Allows private access from package, type or field. See [lf-access-control](lf-access-control). | all
`@:analyzer` |  | Used to configure the static analyzer. | all
`@:annotation` |  | Annotation (`@interface`) definitions on `--java-lib` imports will be annotated with this metadata. Has no effect on types compiled by Haxe. | java
`@:arrayAccess` |  | Allows array access on an abstract. See [types-abstract-array-access](types-abstract-array-access). | all
`@:cs.assemblyMeta` |  | Used to declare a native C# assembly attribute | cs
`@:cs.assemblyStrict` |  | Used to declare a native C# assembly attribute; is type checked | cs
`@:astSource` |  | Filled by the compiler with the parsed expression of the field. | all
`@:autoBuild` | &lt;Build macro call> | Extends `@:build` metadata to all extending and implementing classes. See [macro-auto-build](macro-auto-build). | all
`@:bind` |  | Override SWF class declaration. | flash
`@:bitmap` | &lt;Bitmap file path> | Embeds given bitmap data into the class (must extend `flash.display.BitmapData`). See [target-flash-resources](target-flash-resources). | flash
`@:bridgeProperties` |  | Creates native property bridges for all Haxe properties in this class. | cs
`@:build` | &lt;Build macro call> | Builds a class, enum, or abstract from a macro. See [macro-type-building](macro-type-building). | all
`@:buildXml` |  | Specify XML data to be injected into `Build.xml`. | cpp
`@:bypassAccessor` |  | Do not call property accessor method and access the field directly. See [class-field-property](class-field-property). | all
`@:callable` |  | Abstract forwards call to its underlying type. | all
`@:classCode` |  | Used to inject platform-native code into a class. | java, cs
`@:commutative` |  | Declares an abstract operator as commutative. See [types-abstract-operator-overloading](types-abstract-operator-overloading). | all
`@:const` |  | Allows a type parameter to accept expression values. | all
`@:coreApi` |  | Identifies this class as a core API class (forces API check). | all
`@:coreType` |  | Identifies an abstract as core type so that it requires no implementation. See [types-abstract-core-type](types-abstract-core-type). | all
`@:cppFileCode` |  | Code to be injected into generated cpp file. | cpp
`@:cppInclude` |  | File to be included in generated cpp file. | cpp
`@:cppNamespaceCode` |  |  | cpp
`@:cs.using` |  | Add using directives to your module | cs
`@:dce` |  | Forces dead code elimination even when `--dce full` is not specified. See [cr-dce](cr-dce). | all
`@:debug` |  | Forces debug information to be generated into the SWF even without `--debug`. | flash
`@:decl` |  |  | cpp
`@:delegate` |  | Automatically added by `--net-lib` on delegates. | cs
`@:depend` |  |  | cpp
`@:deprecated` |  | Mark a type or field as deprecated. | all
`@:eager` |  | Forces typedefs to be followed early. | all
`@:enum` |  | Defines finite value sets to abstract definitions. See [types-abstract-enum](types-abstract-enum). | all
`@:event` |  | Automatically added by `--net-lib` on events. Has no effect on types compiled by Haxe. | cs
`@:expose` | &lt;name> | Includes the class or field in Haxe exports (default name is the classpath). See [target-javascript-expose](target-javascript-expose). | js, lua
`@:extern` |  | Marks the field as extern so it is not generated. | all
`@:file` | &lt;File path> | Includes a given binary file into the target SWF and associates it with the class (must extend `flash.utils.ByteArray`). See [target-flash-resources](target-flash-resources). | flash
`@:fileXml` |  | Include a given XML attribute snippet in the `Build.xml` entry for the file. | cpp
`@:final` |  | Prevents a class or interface from being extended or a method from being overridden. Deprecated by the keyword `final`. See [class-field-final](class-field-final). | all
`@:fixed` |  | Declares an anonymous object to have fixed fields. | all
`@:flash.property` |  |  | flash
`@:font` | &lt;TTF path>, &lt;Range String> | Embeds the given TrueType font into the class (must extend `flash.text.Font`). See [target-flash-resources](target-flash-resources). | all
`@:forward` | &lt;List of field names> | Forwards field access to underlying type. See [types-abstract-forward](types-abstract-forward). | all
`@:forward.new` |  | Forwards constructor call to underlying type. | all
`@:forwardStatics` | &lt;List of field names> | Forwards static field access to underlying type. See [types-abstract-forward](types-abstract-forward). | all
`@:forward.variance` |  | Forwards variance unification to underlying type. | all
`@:from` |  | Specifies that the field of the abstract is a cast operation from the type identified in the function. See [types-abstract-implicit-casts](types-abstract-implicit-casts). | all
`@:functionCode` |  | Used to inject platform-native code into a function. | cpp, java, cs
`@:functionTailCode` |  |  | cpp
`@:generic` |  | Marks a class or class field as generic so each type parameter combination generates its own type/field. See [type-system-generic](type-system-generic). | all
`@:genericBuild` |  | Builds instances of a type using the specified macro. | all
`@:genericClassPerMethod` |  | Makes compiler generate separate class per generic static method specialization | all
`@:getter` | &lt;Class field name> | Generates a native getter function on the given field. | flash
`@:hack` |  | Allows extending classes marked as `@:final`. Not guaranteed to work on all targets. | all
`@:headerClassCode` |  | Code to be injected into the generated class, in the header. | cpp
`@:headerCode` |  | Code to be injected into the generated header file. | cpp
`@:headerInclude` |  | File to be included in generated header file. | cpp
`@:headerNamespaceCode` |  |  | cpp
`@:hlNative` |  | Specifies `hdll` name and function prefix for native functions. | hl
`@:hxGen` |  | Annotates that an extern class was generated by Haxe. | java, cs
`@:ifFeature` | &lt;Feature name> | Causes a field to be kept by DCE if the given feature is part of the compilation. See [cr-dce](cr-dce). | all
`@:pythonImport` |  | Generates python import statement for extern classes. | python
`@:include` |  |  | cpp
`@:inheritDoc` |  | Append documentation from a parent field or class (if used without an argument) or from a specified class or field (if used like @:inheritDoc(pack.Some.field)). | all
`@:inline` |  | Inserted by the parser in case of `inline expr` and `inline function`. | all
`@:internal` |  | Generates the annotated field/class with 'internal' access. | java, cs
`@:isVar` |  | Forces a physical field to be generated for properties that otherwise would not require one. See [class-field-property-rules](class-field-property-rules). | all
`@:javaCanonical` | &lt;Output type package>, &lt;Output type name> | Used by the Java target to annotate the canonical path of the type. | java
`@:java.default` |  | Equivalent to the default modifier of the Java language | java
`@:jvm.synthetic` |  | Mark generated class, field or method as synthetic | java
`@:jsRequire` |  | Generate JavaScript module require expression for given extern. See [target-javascript-require](target-javascript-require). | js
`@:luaRequire` |  | Generate Lua module require expression for given extern. | lua
`@:luaDotMethod` |  | Indicates that the given extern type instance should have dot-style invocation for methods instead of colon. | lua
`@:keep` |  | Causes a field or type to be kept by DCE. See [cr-dce](cr-dce). | all
`@:keepInit` |  | Causes a class to be kept by DCE even if all its field are removed. See [cr-dce](cr-dce). | all
`@:keepSub` |  | Extends `@:keep` metadata to all implementing and extending classes. See [cr-dce](cr-dce). | all
`@:markup` |  | Used as a result of inline XML parsing. See [lf-markup](lf-markup). | all
`@:macro` |  | (deprecated) | all
`@:mergeBlock` |  | Merge the annotated block into the current scope. | all
`@:multiReturn` |  | Annotates an extern class as the result of multi-return function. See [target-lua-multireturns](target-lua-multireturns). | lua
`@:multiType` | &lt;Relevant type parameters> | Specifies that an abstract chooses its this-type from its `@:to` functions. | all
`@:native` | &lt;Output path> | Rewrites the path of a type or class field during generation. See [lf-externs](lf-externs). | all
`@:java.native` |  | Annotates that a function has implementation in native code through JNI. | java
`@:nativeChildren` |  | Annotates that all children from a type should be treated as if it were an extern definition - platform native. | java, cs
`@:nativeGen` |  | Annotates that a type should be treated as if it were an extern definition - platform native. | java, cs, python
`@:nativeProperty` |  | Use native properties which will execute even with dynamic usage. | cpp
`@:nativeStaticExtension` |  | Converts static function syntax into member call. | cpp
`@:noCompletion` |  | Prevents the compiler from suggesting completion on this field or type. See [cr-completion](cr-completion). | all
`@:noClosure` |  | Prevents a method or all methods in a class from being used as a value. | all
`@:noDebug` |  | Does not generate debug information even if `--debug` is set. | flash, cpp
`@:noDoc` |  | Prevents a type or field from being included in documentation generation. | all
`@:noImportGlobal` |  | Prevents a static field from being imported with `import Class.*`. | all
`@:nonVirtual` |  | Declares function to be non-virtual in cpp. | cpp
`@:noPrivateAccess` |  | Disallow private access to anything for the annotated expression. | all
`@:noStack` |  |  | cpp
`@:notNull` |  | Declares an abstract type as not accepting null values. See [types-nullability](types-nullability). | all
`@:noUsing` |  | Prevents a field from being used with static extension. See [lf-static-extension](lf-static-extension). | all
`@:nullSafety` | &lt;Off &#x7C; Loose &#x7C; Strict &#x7C; StrictThreaded> | Enables null safety for classes or fields. Disables null safety for classes, fields or expressions if provided with `Off` as an argument. See [cr-null-safety](cr-null-safety). | all
`@:objc` |  | Declares a class or interface that is used to interoperate with Objective-C code. | cpp
`@:objcProtocol` |  | Associates an interface with, or describes a function in, a native Objective-C protocol. | cpp
`@:op` | &lt;The operation> | Declares an abstract field as being an operator overload. See [types-abstract-operator-overloading](types-abstract-operator-overloading). | all
`@:optional` |  | Marks the field of a structure as optional. See [types-nullability-optional-arguments](types-nullability-optional-arguments). | all
`@:overload` | &lt;Function specification (no expression)> | Allows the field to be called with different argument types. See [target-javascript-external-libraries](target-javascript-external-libraries). | all
`@:persistent` |  | Keeps the value of static variables in macro context across compilations. | eval
`@:php.attribute` |  | Adds a PHP attribute to the annotated symbol. Meta argument expects a string constant. E.g. `@:php.attribute('\\my\\Attr(123)')` will be generated as `#[\my\Attr(123)]` in the compiled php file. | php
`@:phpGlobal` |  | Indicates that static fields of an extern class actually are located in the global PHP namespace. | php
`@:phpClassConst` |  | Indicates that a static var of an extern class is a PHP class constant. | php
`@:phpMagic` |  | Treat annotated field as special PHP magic field - this meta makes compiler avoid renaming such fields on generating PHP code. | php
`@:phpNoConstructor` |  | Special meta for extern classes which do not have native constructor in PHP, but need a constructor in Haxe extern. | php
`@:pos` | &lt;Position> | Sets the position of a reified expression. See [macro-reification](macro-reification). | all
`@:publicFields` |  | Forces all class fields of inheriting classes to be public. | all
`@:private` |  | Marks a class field as being private. | cs
`@:privateAccess` |  | Allow private access to anything for the annotated expression. | all
`@:protected` |  | Marks a class field as being protected. | cs, java, flash
`@:property` |  | Marks a field to be compiled as a native C# property. | cs
`@:pure` |  | Marks a class field, class or expression as pure (side-effect free). | all
`@:readOnly` |  | Generates a field with the `readonly` native keyword. | cs
`@:remove` |  | Causes an interface to be removed from all implementing classes before generation. | all
`@:require` | &lt;Compiler flag to check> | Allows access to a field only if the specified compiler flag is set. See [lf-condition-compilation](lf-condition-compilation). | all
`@:resolve` |  | Abstract fields marked with this metadata can be used to resolve unknown fields. | all
`@:rtti` |  | Adds runtime type information. See [cr-rtti](cr-rtti). | all
`@:runtimeValue` |  | Marks an abstract as being a runtime value. | all
`@:scalar` |  | Used by hxcpp to mark a custom coreType abstract. | cpp
`@:selfCall` |  | Translates method calls into calling object directly. See [target-javascript-external-libraries](target-javascript-external-libraries). | js, lua
`@:semantics` | &lt;value &#x7C; reference &#x7C; variable> | The native semantics of the type. | all
`@:setter` | &lt;Class field name> | Generates a native setter function on the given field. | flash
`@:sound` | &lt;File path> | Includes a given .wav or .mp3 file into the target SWF and associates it with the class (must extend `flash.media.Sound`). See [target-flash-resources](target-flash-resources). | flash
`@:sourceFile` |  | Source code filename for external class. | cpp
`@:stackOnly` |  | Instances of this type can only appear on the stack. | cpp
`@:strict` |  | Used to declare a native C# attribute or a native Java metadata; is type checked. | java, cs
`@:struct` |  | Marks a class definition as a struct. | cs, hl
`@:structAccess` |  | Marks an extern class as using struct access (`.`) not pointer (`->`). | cpp
`@:structInit` |  | Allows one to initialize the class with a structure that matches constructor parameters. | all
`@:suppressWarnings` |  | Adds a `SuppressWarnings` annotation for the generated Java class. | java
`@:templatedCall` |  | Indicates that the first parameter of static call should be treated as a template argument. | cpp
`@:throws` | &lt;Type as String> | Adds a `throws` declaration to the generated function. | java
`@:to` |  | Specifies that the field of the abstract is a cast operation to the type identified in the function. See [types-abstract-implicit-casts](types-abstract-implicit-casts). | all
`@:transient` |  | Adds the `transient` flag to the class field. | java
`@:transitive` |  | Allows transitive casts with an abstract. | all
`@:volatile` |  |  | java, cs
`@:unifyMinDynamic` |  | Allows a collection of types to unify to `Dynamic`. | all
`@:unreflective` |  |  | cpp
`@:unsafe` |  | Declares a class, or a method with the C#'s `unsafe` flag. | cs
`@:using` |  | Automatically uses the argument types as static extensions for the annotated type. See [lf-static-extension-metadata](lf-static-extension-metadata). | all
`@:haxe.warning` |  | Modifies warning options, equivalent to the -w CLI argument | all
`@:void` |  | Use Cpp native `void` return type. | cpp
`@:nativeArrayAccess` |  | When used on an extern class which implements haxe.ArrayAccess native array access syntax will be generated | cpp
