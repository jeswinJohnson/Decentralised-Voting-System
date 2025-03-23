// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AddOperator extends StatefulWidget {
  const AddOperator({super.key});

  @override
  State<AddOperator> createState() => _AddOperatorState();
}

class _AddOperatorState extends State<AddOperator> {
  @override
  Widget build(BuildContext context) {

    List<String> operators = ["Operator1", "Operator2", "Operator3"];

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
                    decoration: InputDecoration(
                      hintText: "Operator Address"
                    ),
                  )
                )
              ),

              SizedBox(width: 20),
              
              FilledButton(
                onPressed: () => print(""), 
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

          Expanded(
            child: ListView.builder(
              itemCount: operators.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(operators[index]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}