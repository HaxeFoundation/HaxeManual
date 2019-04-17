class Main {
  static public function main() {
    final a = [1, 2, 3];
    trace(a); // [1, 2, 3]
    
    // the following line would cause a compilation error:
    // a = [1, 2, 3, 4];
    
    // but the following line works:
    a.push(4);
    trace(a); // [1, 2, 3, 4]
  }
}