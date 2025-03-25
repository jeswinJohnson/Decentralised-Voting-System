// ignore_for_file: prefer_const_constructors
import 'package:eci_app/sideBar.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;

TextEditingController privateKeyController = TextEditingController();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    login(context){
      if(privateKeyController.text == ""){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Private Key Cannot be Empty!')));
      }else{
        global.privateKey = privateKeyController.text;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SideBar()));
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              SizedBox(
                width: 400,
                child: TextField(
                  controller: privateKeyController,
                  decoration: InputDecoration(
                    hintText: "Enter Private Key"
                  ),
                ),
              ),
          
              SizedBox(
                height: 10,
              ),
          
              FilledButton(
                onPressed: () => login(context),
                child: const Text("Login")
              ),
            ],
          ),
        ),
      ),
    );
  }
}