import 'package:flutter/material.dart';

class CommonColors {
  static final primaryColorDark = _getColor(0xFFA9C8F6);
  static final Color scaffoldColorDark = _getColor(0xFF444444);
  static final Color buttonColorDark = _getColor(0xFF778BD9);

  static final Map<int, Color> _color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };

  static MaterialColor _getColor(int primary) {
    return MaterialColor(primary, _color);
  }
}
