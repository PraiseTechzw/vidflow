import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade900,
    secondary: Colors.grey.shade800,
    surface: Colors.black,
    background: Colors.black,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
  ),
);

final ThemeData blueTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.lightBlue,
    surface: Colors.lightBlueAccent,
    background: Colors.blueGrey,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
);

final ThemeData greenTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  colorScheme: const ColorScheme.light(
    primary: Colors.green,
    secondary: Colors.lightGreen,
    surface: Colors.lightGreenAccent,
    background: Colors.greenAccent,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
);

final ThemeData redTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.red,
  colorScheme: const ColorScheme.light(
    primary: Colors.red,
    secondary: Colors.redAccent,
    surface: Colors.redAccent,
    background: Colors.red,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
);
