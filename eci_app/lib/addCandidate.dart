import 'package:flutter/material.dart';

class AddCandidate extends StatefulWidget {
  const AddCandidate({super.key});

  @override
  State<AddCandidate> createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {
  @override
  Widget build(BuildContext context) {
    List<String> candidates = ["Operator1", "Operator2", "Operator3"];

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
                    decoration: InputDecoration(hintText: "Party Name"),
                  ))),
              SizedBox(width: 20),
              FilledButton(onPressed: () => print(""), child: Text("Add"))
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
          Expanded(
            child: ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(candidates[index]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
