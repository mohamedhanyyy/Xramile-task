import 'package:flutter/material.dart';

class Palette {
  static MaterialColor kToDark = MaterialColor(
    Colors.white.value,
    <int, Color>{
      50: Colors.white.withOpacity(0.1), //10%
      100: Colors.white.withOpacity(0.2), //20%
      200: Colors.white.withOpacity(0.3), //30%
      300: Colors.white.withOpacity(0.4), //40%
      400: Colors.white.withOpacity(0.5), //50%
      500: Colors.white.withOpacity(0.6), //60%
      600: Colors.white.withOpacity(0.7), //70%
      700: Colors.white.withOpacity(0.8), //80%
      800: Colors.white.withOpacity(0.9), //90%
      900: Colors.white, //100%
    },
  );
}
