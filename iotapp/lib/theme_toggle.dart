import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;
  final ThemeMode currentThemeMode;

  ThemeToggleButton({
    required this.onThemeChanged,
    required this.currentThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(currentThemeMode == ThemeMode.light
          ? Icons.nights_stay
          : Icons.wb_sunny),
      onPressed: () {
        ThemeMode newTheme = currentThemeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
        onThemeChanged(newTheme);
      },
    );
  }
}
