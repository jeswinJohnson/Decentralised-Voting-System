import 'package:eci_app/sideBar.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SideBar())),
          child: const Text("Login")
        ),
      ),
    );
  }
}