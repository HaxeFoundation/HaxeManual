## 8.3 Completion

Because of the high number of Haxe features and its powerful type inference, [IDE and code editors](http://haxe.org/documentation/introduction/editors-and-ides.html) cannot easily handle completion by parsing the Haxe files. Haxe provides completion support for IDEs directly built in the compiler thanks to the `--display` commandline parameter.

Let's have a look at the following example :
```haxe
class Test {
    public static function main() {
        trace("Hello".|
    }
}
```

The vertical bar indicates the cursor position after the dot has been pressed. At this time, it is the job of the IDE to call the Haxe compiler with usual compilation parameters, plus an additional one `--display Test.hx@73`.

This parameter determines the file in which we want some completion and the byte position of the cursor in the file. In the example given, you should get 73 if you count characters with windows CRLF lines ending.

Haxe will perform all the parsing and typing as it would do for normal compilation, except that it will not generate any code. If it reaches the byte 73 in the file `Test.hx` during compilation, it will output the information about the type of the expression on the left of the dot.

In our case, that would be `String`. The exception being that in the case of an anonymous object or a class instance, the compiler will instead list the different fields in an XML and print them to a possible output:

```haxe
<list>
<i n="length"><t>Int</t><d>...</d></i>
<i n="charAt"><t>index : Int -> String</t><d>...</d></i>
<i n="charCodeAt"><t>index : Int -> Int</t><d>...</d></i>
<i n="indexOf">
  <t>value : String -> ?startIndex : Int -> Int</t>
  <d>...</d>
</i>
...
</list>
```

In that case, all public methods and fields of `String` are listed. This information can directly be used by the IDE to provide code hints and completion.

###### Functions completion
This completion mechanism works with both dot and opening parenthesis, so you can get type information about fields lists and function call arguments types:

```haxe
class Test {
    public static function main() {
        trace("Hello".split(|
    }
}
```

This will give you the following result: `<type>delimiter : String -> Array<String></type>` _(please note that the content of the type is not html-escaped in the real output)_

###### Package completion
It also works with packages by scanning the .hx files available in the classpath:

```haxe
import haxe.|
Will return :

<list>
    <i n="BaseCode"><t></t><d></d></i>
    <i n="EnumFlags"><t></t><d></d></i>
    ...
    <i n="io"><t></t><d></d></i>
    <i n="macro"><t></t><d></d></i>
    <i n="remoting"><t></t><d></d></i>
    ...
</list>
```

###### Error Handling
When run in completion mode, the compiler will not display errors but instead try to ignore them or recover from them. 

If a not recoverable error occurs while getting completion, the Haxe compiler will print the error message instead of the completion output. You can then treat any not-XML output as an error message which prevents the completion.

###### Compilation cache server
##### since Haxe 2.09

Get the best speed for both compilation and completion, you can use the `--wait` commandline parameter to start a Haxe compilation server. You can also use `-v` to have the server print the log. Here's an example:

```haxe
haxe -v --wait 6000
```

You can then connect to the Haxe server, send commandline parameters followed by a 0 byte and then read the response (either completion result or errors).

Use the `--connect` commandline parameter to have Haxe send its compilation commands to the server instead of executing them directly :

```haxe
haxe --connect 6000 myproject.hxml
```

Please note that you can use `--cwd` at the first sent commandline parameter to change the Haxe server's current working directory. Usually class paths and other files are relative to your project.

###### How it works
The compilation server will cache the following things:

* parsed files the files will only get parsed again if they are modified or if there was a parse error
* haxelib calls the previous results of haxelib calls will be reused (only for completion : they are ignored when doing a compilation)
* typed modules compilation modules will be cached after a successful compilation and can be reused in later compilation/completions if none of their dependencies have been modified

You can get precise reading of the times spent by the compiler and how using the compilation server affects it by adding the `--times` command line.

###### Protocol
As the following Haxe/Neko example shows, you can simply connect on the server port and send all commands (one per line) ending with a 0 binary char. You can then read the results.

Macros and other commands can log events which are not errors. From the command line we can see the difference between what is printed on `stdout` and what is print on `stderr`. This is not the case in socket mode. In order to differentiate between the two, log messages (not errors) are prefixed with a `
x01` character and all newline-characters in the message are replaced by the same `
x01` character.
warnings and other messages can also be considered errors, but are not fatal ones. If a fatal error occurred, we will send a single `
x02` message-line
Here's some code that will treat connect to the server and handle the protocol details :

```haxe
class Test {
    static function main() {
		var newline = "\\ n";
        var s = new neko.net.Socket();
        s.connect(new neko.net.Host("127.0.0.1"),6000);
        s.write("--cwd /my/project" + newline);
        s.write("myproject.hxml" + newline);
        s.write("\\ 000");

        var hasError = false;
        for (line in s.read().split(newline))
		{
            switch (line.charCodeAt(0)) {
				case 0x01: 
					neko.Lib.print(line.substr(1).split("\\ x01").join(newline));
				case 0x02: 
					hasError = true;
				default: 
					neko.io.File.stderr().writeString(line + newline);
            }
		}
        if (hasError) neko.Sys.exit(1);
    }
}
```

###### Effect on macros
The compilation server can have some side effects on [macro execution](macro.md).

---

Previous section: [Dead Code Elimination](cr-dce.md)

Next section: [Resources](cr-resources.md)