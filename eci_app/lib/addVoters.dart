import 'package:eci_app/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVoters extends StatefulWidget {
  const AddVoters({super.key});

  @override
  State<AddVoters> createState() => _AddVotersState();
}

TextEditingController voterId = TextEditingController();
TextEditingController voterName = TextEditingController();


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
                controller: voterName,
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
                controller: voterId,
                decoration: InputDecoration(hintText: "Voter Identification"),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          FilledButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Center(child: SizedBox(child: CircularProgressIndicator())));

              if (voterId.text == "" || voterName.text == "") {
                Get.snackbar(
                  "Title",
                  "Voter name or id cannot be empty",
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                Get.snackbar(
                  "Title",
                  await addVoter(voterName.text, voterId.text),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }

              Navigator.pop(context);
            },  
            child: Text("Add")
          )
        ],
      ),
    );
  }
}
