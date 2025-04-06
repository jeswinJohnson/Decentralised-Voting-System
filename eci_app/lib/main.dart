// ignore_for_file: prefer_const_constructors

import 'package:eci_app/global.dart';
import 'package:eci_app/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
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
