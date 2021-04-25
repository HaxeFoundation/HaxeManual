class Main {
  static function main() {
    final gitCommand = 'git log --format=short --no-decorate -n1 --oneline';
    final process = new sys.io.Process(gitCommand);
    if (process.exitCode() != 0) {
      trace("Error running process command");
    }
    final lastCommitInfo = process.stdout.readLine();
    trace(lastCommitInfo);
    process.close();
  }
}
