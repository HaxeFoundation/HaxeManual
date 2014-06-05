class MathExample {
  static public function main() {

    var x = 1/2;
    var y = 20.2;
    var z = -2;

    trace(Math.abs(z)); //2
    trace(Math.sin(x*Math.PI)); //1
    trace(Math.ceil(y)); //21

    // log is the natural logarithm
    trace(Math.log(Math.exp(5))); //5

    // Output for neko target, may vary
    // depending on platform
    trace(1/0); //inf
    trace(-1/0); //-inf
    trace(Math.sqrt(-1)); //nan
  }
}

