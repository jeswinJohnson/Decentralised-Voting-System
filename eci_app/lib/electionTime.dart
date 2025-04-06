// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:eci_app/logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElectionTime extends StatefulWidget {
  const ElectionTime({super.key});

  @override
  State<ElectionTime> createState() => _ElectionTimeState();
}

DateTime? startTime = DateTime.now();
DateTime? endTime = DateTime.now();

class _ElectionTimeState extends State<ElectionTime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: electionTime(),
          builder: (context, snapShot) {
            if (snapShot.connectionState != ConnectionState.done) {
              return Center(
                child: SizedBox(child: CircularProgressIndicator()),
              );
            }

            if (snapShot.data == null) {
              return Center(
                child: Text("Sorry, Error Occured!"),
              );
            }

            var electionTime = snapShot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Election Timing",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Current Election Time",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Start: ${DateTime.fromMillisecondsSinceEpoch(electionTime["electionStart"] * 1000).toString()}",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      "End Time: ${DateTime.fromMillisecondsSinceEpoch(electionTime["electionEnd"] * 1000).toString()}",
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Updated Election Time",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 300,
                      child: Column(
                        children: [
                          Text(
                            "Start Date",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            startTime.toString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FilledButton(
                              onPressed: () async {
                                startTime = (await showDatePicker(
                                  context: context,
                                  initialDate: startTime,
                                  firstDate: DateTime(1995, 1, 1),
                                  lastDate: DateTime(2030, 1, 1),
                                ));

                                setState(() {});
                              },
                              child: Text(
                                "Edit Start Date",
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      width: 300,
                      child: Column(
                        children: [
                          Text(
                            "End Date",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            endTime.toString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FilledButton(
                              onPressed: () async {
                                endTime = (await showDatePicker(
                                  context: context,
                                  initialDate: endTime,
                                  firstDate: DateTime(1995, 1, 1),
                                  lastDate: DateTime(2030, 1, 1),
                                ));

                                setState(() {});
                              },
                              child: Text(
                                "Edit Start Date",
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(child: SizedBox(child: CircularProgressIndicator()))
                      );


                      if(startTime == null || endTime == null){
                        Get.snackbar(
                          "Title",
                          "Private Key Cannot be Empty!",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }else{
                        Get.snackbar(
                          "Title",
                          "${await updateTime(startTime!, endTime!)}",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }

                      Navigator.pop(context);
                    },
                    child: Text("Update Timing"))
              ],
            );
          }),
    );
  }
}
