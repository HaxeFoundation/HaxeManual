abstract MyAbstract(Int) {
  public function subtract(b:MyAbstract):MyAbstract {
    return new MyAbstract(this - b);
  }
  
  public function subtractFrom(b:MyAbstract):MyAbstract {
    return b.subtract(abstract);
  }
                      
  public function new(value:Int) {
    this = value;
  }                    
}
