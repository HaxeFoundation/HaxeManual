## 8.3.8 Completion server

To get the best speed for both compilation and completion, you can use the `--wait` commandline parameter to start a Haxe compilation server. You can also use `-v` to have the server print the log. Here's an example:

```haxe
haxe -v --wait 6000
```

You can then connect to the Haxe server, send commandline parameters followed by a 0 byte and, then, read the response (either completion result or errors).

Use the `--connect` commandline parameter to have Haxe send its compilation commands to the server instead of executing them directly :

```haxe
haxe --connect 6000 myproject.hxml
```

Please note that you can use the parameter `--cwd` at the first sent command line to change the Haxe server's current working directory. Usually class paths and other files are relative to your project.

###### How it works
The compilation server will cache the following things:

* parsed files the files will only get parsed again if they are modified or if there was a parse error
* haxelib calls the previous results of haxelib calls will be reused (only for completion : they are ignored when doing a compilation)
* typed modules compilation modules will be cached after a successful compilation and can be reused in later compilation/completions if none of their dependencies have been modified

You can get precise reading of the times spent by the compiler and how using the compilation server affects them by adding `--times` to the command line.

###### Protocol
As the following Haxe/Neko example shows, you can simply connect on the server port and send all commands (one per line) ending with a 0 binary char. You can, then, read the results.

Macros and other commands can log events which are not errors. From the command line, we can see the difference between what is printed on `stdout` and what is print on `stderr`. This is not the case in socket mode. In order to differentiate between the two, log messages (not errors) are prefixed with a `
x01` character and all newline-characters in the message are replaced by the same `
x01` character.

Warnings and other messages can also be considered errors, but are not fatal ones. If a fatal error occurred, it will send a single `
x02` message-line.

Here's some code that will treat connection to the server and handle the protocol details:

```haxe
class Test {
    static function main() {
		var newline = "\ n";
        var s = new neko.net.Socket();
        s.connect(new neko.net.Host("127.0.0.1"),6000);
        s.write("--cwd /my/project" + newline);
        s.write("myproject.hxml" + newline);
        s.write("\ 000");

        var hasError = false;
        for (line in s.read().split(newline))
		{
            switch (line.charCodeAt(0)) {
				case 0x01: 
					neko.Lib.print(line.substr(1).split("\ x01").join(newline));
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

Previous section: [Top-level completion](cr-completion-top-level.md)

Next section: [Resources](cr-resources.md)