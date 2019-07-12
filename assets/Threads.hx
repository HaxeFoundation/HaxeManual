class Main {
  public static function main():Void {
    #if (target.threaded)
    sys.thread.Thread.create(() -> {
      while (true) {
        trace("other thread");
        Sys.sleep(1);
      }
    });
    Sys.sleep(3);
    #end
  }
}
