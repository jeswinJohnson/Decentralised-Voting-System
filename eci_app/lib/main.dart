// ignore_for_file: prefer_const_constructors

import 'package:eci_app/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displayMedium: TextStyle(
            color: Colors.black, 
            decoration: TextDecoration.none
          ),

          displaySmall: TextStyle(
            color: Colors.black, 
            fontSize: 20,
            decoration: TextDecoration.none
          )
        )
      ),
      home: const Login()
    );
  }
}
