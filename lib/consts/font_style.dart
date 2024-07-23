import 'package:flutter/material.dart';

class FontStyle {
  TextStyle style(double size, Color color) {
    return TextStyle(
      fontFamily: "ABeeZee",
      fontSize: size,
      color: color,
    );
  }

  TextStyle boldStyle(double size, Color color) {
    return TextStyle(
      fontFamily: "ABeeZee",
      fontSize: size,
      color: color,
      fontWeight: FontWeight.bold
    );
  }
}
