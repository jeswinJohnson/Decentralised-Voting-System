// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eci_app/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOperator extends StatefulWidget {
  const AddOperator({super.key});

  @override
  State<AddOperator> createState() => _AddOperatorState();
}

TextEditingController operatorIdController = TextEditingController();

class _AddOperatorState extends State<AddOperator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add Operator",
            style: Theme.of(context).textTheme.displayMedium,
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              SizedBox(
                width: 350, 
                child: Material(
                  child: TextField(
                    controller: operatorIdController,
                    decoration: InputDecoration(
                      hintText: "Operator Address"
                    ),
                  )
                )
              ),

              SizedBox(width: 20),
              
              FilledButton(
                onPressed: () async {

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(child: SizedBox(child: CircularProgressIndicator()))
                  );


                  if(operatorIdController.text == ""){
                    Get.snackbar(
                      "Title",
                      "Operator ID Cannot Be Empty!",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }else{
                    Get.snackbar(
                      "Title",
                      await addOperator(operatorIdController.text),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }

                  Navigator.pop(context);
                }, 
                child: Text("Add")
              )
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Text(
            "Operators List",
            style: Theme.of(context).textTheme.displaySmall,
          ),

          SizedBox(
            height: 8,
          ),

          FutureBuilder(
            future: getOperators(),
            builder: (context, snapShot) {

              if(snapShot.connectionState != ConnectionState.done){
                return SizedBox(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapShot.data == null) {
                return Center(
                  child: Text("Sorry, Error Occured!"),
                );
              }

              var responseData = snapShot.data!;

              return Expanded(
                child: ListView.builder(
                  itemCount: responseData["operators"].length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(responseData["operators"][index]),
                    ),
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}