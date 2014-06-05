class MathStaticExtension {
  /* Converts an angle in radians to degrees */
  inline public static function
  toDegrees (radians :Float) :Float
  {
    return radians * 180/Math.PI;
  }
}

