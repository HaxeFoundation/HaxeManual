class Main {
  static function main() {
    var newline = "\n";
    var s = new sys.net.Socket();
    s.connect(new sys.net.Host("127.0.0.1"), 6000);
    s.write("--cwd /my/project" + newline);
    s.write("myproject.hxml" + newline);
    s.write("\000");

    var hasError = false;
    for (line in s.read().split(newline)) {
      switch (line.charCodeAt(0)) {
        case 0x01:
          Sys.print(line.substr(1).split("\x01").join(newline));
        case 0x02:
          hasError = true;
        default:
          Sys.stderr().writeString(line + newline);
      }
    }
    if (hasError)
      Sys.exit(1);
  }
}
