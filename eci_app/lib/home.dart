// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class Candiate{
  String name;
  int voteCount;

  Candiate(this.name, this.voteCount);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    List<Candiate> candidateStatus = [Candiate("party1", 0), Candiate("party2", 2), Candiate("party3", 1)];
    candidateStatus.sort((a,b) => b.voteCount.compareTo(a.voteCount));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Election Status",
            style: Theme.of(context).textTheme.displayMedium,
          ),

          SizedBox(
            height: 10,
          ),

          Text(
            "Election Time",
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text(
                "Total Votes: {some time}",
                style: Theme.of(context).textTheme.displaySmall,
              ),

              Text(
                "Last Update: {some time}",
                style: Theme.of(context).textTheme.displaySmall,
              )

            ],
          ),

          SizedBox(
            height: 10,
          ),

          Text(
            "Election Status",
            style: Theme.of(context).textTheme.displaySmall,
          ),

          SizedBox(
            height: 8,
          ),

          Expanded(
            child: ListView.builder(
              itemCount: candidateStatus.length,
              itemBuilder:(context, index) => Card(
                child: ListTile(
                  title: Text(candidateStatus[index].name),
                  subtitle: Text("Vote Count: ${candidateStatus[index].voteCount}"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}