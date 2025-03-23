import 'package:flutter/material.dart';

class AddVoters extends StatefulWidget {
  const AddVoters({super.key});

  @override
  State<AddVoters> createState() => _AddVotersState();
}

class _AddVotersState extends State<AddVoters> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add Voters",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: 10,
          ),
         
         Material(
           child: SizedBox(
            width: 150,
             child: TextField(
                decoration: InputDecoration(hintText: "Voter Name"),
              ),
           ),
         ),

          SizedBox(
            height: 10,
          ),

          Material(
            child: SizedBox(
              width: 150,
              child: TextField(
                decoration: InputDecoration(hintText: "Voter Identification"),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          FilledButton(onPressed: () => print(""), child: Text("Add"))
        ],
      ),
    );
  }
}
