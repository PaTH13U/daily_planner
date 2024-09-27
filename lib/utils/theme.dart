import 'package:flutter/material.dart';

const Color blueClr = Color(0xFF4e54c8);
const Color yellowClr = Color(0xFFffa400);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = blueClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static const light = (
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static const dark = (
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
