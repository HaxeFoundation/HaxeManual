## 12.5.2 The Hxcpp Build Environment

The hxcpp build environment can be controlled by setting, or defining, variables in key-value pairs. Defining a key without a particular value is usually enough to trigger the desired behaviour, and these keys are often referred to as "defines".

##### Defining From the Command Line
The easiest way to change the hxcpp build environment is to pass the defines though the Haxe command line using `-D`.  Key-value pairs can also be passed this way, e.g.:

` haxe -main Main -cpp cpp -D android -D static_link  -D PLATFORM=android-9 `

Here, `android` is defined - this causes hxcpp to cross-compile to android, `static_link` is defined, which causes a static (rather than dynamic) library to be created and the android target platform is set to a particular value.  This platform information is passed on to the SDK so it can generate the appropriate code.

Advanced users can add additional defines to the system at compile time using macros.  These definitions will also be passed on to the hxcpp build tool.

##### Defining From the System Environment Variables
The hxcpp build tool will import all the system environment variables, so you can configure the processes using the system like:

` setenv HXCPP_VERBOSE `

If you are running Haxe though an IDE, some care must be taken with environment variables since the variables may be read once from the environment in which the IDE was started, rather than changing when the variables are changed on the system.

##### Defining From .hxcpp_config.xml
The hxcpp build tool parses several "build files".  These files are in a basic xml file format, and can be used to set, or conditionally set, configuration variables.  As part of the build process, the `.hxcpp_config.xml` file, known as the configuration file, will be read (twice).  This file is located in the user's home directory (or user's profile directory on windows) and is the best place to configure variables that are specific to the system that rarely change, such as the location of the cross-compiler SDKs.  A placeholder file will be generated the first time hxcpp is run by a user on the machine.  You can see the exact location of this file in the build log if you compile with the `HXCPP_VERBOSE` define.

The configuration file is read twice.  The first time the `"vars"` section is read early in the configuration process, and is used to set up and configure the location of the compilers.  The second time, the `"exes"` section is read near the end of the processes and allows modification of the compiler or build process based on all the available information.  See [build.xml File Format](target-cpp-file-format.md) for details on the file format.

##### Defining Via @:buildXml Metadata
Configuration data can be injected into the "build.xml" file that is created by Haxe.  This is done attaching metadata to a Haxe class that is directly or indirectly included in the build.  For example:
```haxe
@:buildXml("
<target id='haxe'>
  <lib name='${haxelib:nme}/lib/${BINDIR}/libnme${LIBEXTRA}${LIBEXT}'/>
</target>
<include name='${haxelib:nme}/lib/NmeLink.xml'/>
")
@:keep class StaticNme
{
  ...
```

This metadata is best for adding libraries or include paths to the build.
Some notes:

* The @:keep metadata is added to prevent dead-code-elimination from removing this class
* Quoting can be a bit tricky - here the double-quotes are used for Haxe, and the single quotes are added to the build.xml.
* Injecting a single "include" command is a good way to manage the quoting issue.
* Knowledge of the build system is required to get this right. See [build.xml File Format](target-cpp-file-format.md) for details on the file format.
* The build.xml file is read after the choice of compiler has been made, so it is generally not suitable for configuring the compiler.

---

Previous section: [Getting started with Haxe/C++](target-cpp-getting-started.md)

Next section: [build.xml File Format](target-cpp-file-format.md)