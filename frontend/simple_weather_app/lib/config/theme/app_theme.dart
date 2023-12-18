import 'package:flutter/material.dart';

const Color _customColor = Color(0x0099FF01);

const List<Color> _colorThemes = [
  _customColor,
  Colors.black,
  Colors.blue,
  Colors.white,
  Colors.grey,
  Colors.purple
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            "Selected color must be between 0 and ${_colorThemes.length}.");

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
    );
  }
}
