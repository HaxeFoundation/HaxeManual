import haxe.macro.Context;
import haxe.macro.Expr;

class TypeBuildingMacro {
  macro static public function
  build(fieldName:String):Array<Field> {
    var fields = Context.getBuildFields();
    var newField = {
      name: fieldName,
      doc: null,
      meta: [],
      access: [AStatic, APublic],
      kind: FVar(macro : String,
        macro "my default"),
      pos: Context.currentPos()
    };
    fields.push(newField);
    return fields;
  }
}