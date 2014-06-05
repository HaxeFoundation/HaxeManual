import haxe.macro.Context;
import haxe.macro.Expr;

class AutoBuildingMacro {
  macro static public
  function fromInterface():Array<Field> {
    trace("fromInterface: "
      + Context.getLocalType());
    return null;
  }

  macro static public
  function fromBaseClass():Array<Field> {
    trace("fromBaseClass: "
      + Context.getLocalType());
    return null;
  }
}