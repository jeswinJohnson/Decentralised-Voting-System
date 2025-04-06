// ignore_for_file: prefer_const_constructors

import 'package:eci_app/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCandidate extends StatefulWidget {
  const AddCandidate({super.key});

  @override
  State<AddCandidate> createState() => _AddCandidateState();
}

TextEditingController partyNameController = TextEditingController();

class _AddCandidateState extends State<AddCandidate> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add Candidate",
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
                      controller: partyNameController,
                      decoration: InputDecoration(hintText: "Party Name"),
                  ))),
              SizedBox(width: 20),
              FilledButton(
                onPressed: () async {

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(child: SizedBox(child: CircularProgressIndicator()))
                  );


                  if(partyNameController.text == ""){
                    Get.snackbar(
                      "Title",
                      "Party Name Cannot Be Empty!",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }else{
                    Get.snackbar(
                      "Title",
                      "${await addParty(partyNameController.text)}",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }

                  Navigator.pop(context);
                },
              child: Text("Add"))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Candidates List",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(
            height: 8,
          ),
          
          FutureBuilder(
            future: getCandidates(),
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
                  itemCount: responseData["candidates"].length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(responseData["candidates"][index]),
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
