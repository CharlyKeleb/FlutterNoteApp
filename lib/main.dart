import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/util/constants.dart';

void main() => runApp((MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Constants.lightTheme,
      home: HomeScreen(),
    );
  }
}

