// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eci_app/logic.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: electionStatus(),
        builder: (context, snapShot) {
          
          if(snapShot.connectionState != ConnectionState.done){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapShot.data == null){
            return Center(
              child: Text("Sorry, Error Occured!"),
            );
          }

          Map<String, dynamic> electionStatusData = snapShot.data!;
          List<Candiate> candidateStatus = [];
          for(int i=0; i<electionStatusData["candiates"].length; i++){
            candidateStatus.add(Candiate(electionStatusData["candiates"][i]["name"], electionStatusData["candiates"][i]["voteCount"]));
          }
          candidateStatus.sort((a,b) => b.voteCount.compareTo(a.voteCount));

          return Column(
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
                    "Start: ${electionStatusData["electionStart"]}",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
          
                  Text(
                    "End Time: ${electionStatusData["electionEnd"]}",
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
                    "Total Votes: ${electionStatusData["totalVotes"]}",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
          
                  Text(
                    "Last Update: ${DateTime.now().toString()}",
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
          );
        }
      ),
    );
  }
}