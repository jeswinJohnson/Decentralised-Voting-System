// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElectionTime extends StatefulWidget {
  const ElectionTime({super.key});

  @override
  State<ElectionTime> createState() => _ElectionTimeState();
}

class _ElectionTimeState extends State<ElectionTime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                "Start: {some time}",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                "End Time: {some time}",
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
                    
                    Expanded(
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (onDateTimeChanged) => print(onDateTimeChanged)
                      ),
                    ),
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
                    
                    Expanded(
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (onDateTimeChanged) => print(onDateTimeChanged)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          FilledButton(
            onPressed: () => print("timing"), 
            child: Text("Update Timing")
          )
        ],
      ),
    );
  }
}