import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static const int maxValue = 1000000;
  static const Color primaryColor = Color(0xFF63B3FF);
  static Color startColor = Colors.green[400]!;
  static Color endColor = Colors.red[400]!;
  static Color visitedColor = Colors.cyan[400]!;
  static Color shortColor = Colors.amber[400]!;
  static Color wallColor = Colors.black;

  static TextStyle bodyStyle = GoogleFonts.openSans().copyWith(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
}
