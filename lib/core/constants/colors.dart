import 'package:flutter/material.dart';

class Colours {
  Colours._();
  static const kFirstColor = Color(0xFFC4A1F);
  static const kSecondColor = Color(0xFFAF1055);
  static const kTertiaryTextColor = Color(0xFFA7A7A7);

  static LinearGradient kAppGradient =
      LinearGradient(colors: [kFirstColor, kSecondColor]);
}
