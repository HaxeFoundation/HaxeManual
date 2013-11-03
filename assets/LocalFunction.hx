
Class MyClass{
  var x : Int;

  function f1() {
    //Can not access 'this'.  WILL NOT COMPILE!
    var add = function(n) {this.x += n;};
  }

  function f2() {
    //will compile
    var me = this;
    var add = function(n) {me.x += n;};
  }

}


