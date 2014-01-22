// Conditional based on if...else if statements
if( v == 0 )
  e1;
else if( v == foo(1) )
  e2;
else if( v == 65 || v == 90 )
  e3;
else
  e4;


// Same conditional check using switch
switch( v ) {
  case 0:
    e1;
  case foo(1):
    e2;
  case 65, 90:
    e3;
  default:
    e4;
}
