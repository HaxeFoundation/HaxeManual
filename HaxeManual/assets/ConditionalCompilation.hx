class ConditionalCompilation {
  public static function main(){
    #if !debug
      trace("ok");
    #elseif (debug_level > 3)
      trace(3);
    #else
      trace("debug level too low");
    #end
  }
}