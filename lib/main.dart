import 'package:flutter/material.dart';
import 'package:vidflow/screens/downloads.dart';
import 'package:vidflow/screens/home.dart';
import 'package:vidflow/screens/searchscreen.dart';
import 'package:vidflow/screens/settings.dart';
import 'package:vidflow/themes/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData = lightTheme;

  void changeTheme(ThemeData theme) {
    setState(() {
      _themeData = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: const Home(),
      routes: {
        "/home": (context) => Home(),
        "/settings": (context) => Settings(),
        "/Downloads": (context) => Downloads(),
        "/searchscreen": (context) => SearchScreen(),
      },
    );
  }
}
