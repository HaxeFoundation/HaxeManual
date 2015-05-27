class Main {
  static function main() {
    new Main();
  }

  public function new() {
    var user = {name:"Mark", distance:3500};
    var sample = "The results: $$display(::user::,::time::)";
    var template = new haxe.Template(sample);
    var output = template.execute({user:user, time: 15}, this);
    trace(output);
  }

  function display(resolve:String->Dynamic, user:User, time:Int) {
    return user.name + " ran " + (user.distance/1000) + " kilometers in " + time + " minutes";
  }
}
typedef User = {name:String, distance:Int}
