enum Color{
  Red;
  Green;
  Blue;
}

var myColor : Color

//...

switch( myColor ){
  case Red: 0xFF0000;
  case Green: 0x00ff00;
}
// will cause a compile warning because 'Blue'
// is missing
