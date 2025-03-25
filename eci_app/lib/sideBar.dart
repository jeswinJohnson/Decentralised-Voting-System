// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eci_app/addCandidate.dart';
import 'package:eci_app/addOperator.dart';
import 'package:eci_app/addVoters.dart';
import 'package:eci_app/electionTime.dart';
import 'package:eci_app/home.dart';
import 'package:eci_app/login.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

Widget currentPage = Home();

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {

    if(global.privateKey == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 60,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      currentPage = Home();
                    }),
                    isSelected: currentPage.toString() == "Home",
                    selectedIcon: Icon(Icons.home, color: Colors.white,),
                    icon: Icon(Icons.home)
                  ),
                  
                  // Election Time
                  IconButton(
                    onPressed: () => setState(() {
                      currentPage = ElectionTime();
                    }),
                    isSelected: currentPage.toString() == "ElectionTime",
                    selectedIcon: Icon(Icons.timelapse_sharp, color: Colors.white,),
                    icon: Icon(Icons.timelapse_sharp)
                  ),
                  
                  // Add Operator
                  IconButton(
                    onPressed: () => setState(() {
                      currentPage = AddOperator();
                    }),
                    isSelected: currentPage.toString() == "AddOperator",
                    selectedIcon: Icon(Icons.person, color: Colors.white,),
                    icon: Icon(Icons.person)
                  ),
                  
                  // Add Candidate
                  IconButton(
                    onPressed: () => setState(() {
                      currentPage = AddCandidate();
                    }),
                    isSelected: currentPage.toString() == "AddCandidate",
                    selectedIcon: Icon(Icons.flag, color: Colors.white,),
                    icon: Icon(Icons.flag)
                  ),
                  
                  // Add Voters
                  IconButton(
                    onPressed: () => setState(() {
                      currentPage = AddVoters();
                    }),
                    isSelected: currentPage.toString() == "AddVoters",
                    selectedIcon: Icon(Icons.how_to_vote_rounded, color: Colors.white,),
                    icon: Icon(Icons.how_to_vote_rounded)
                  ),
                ],
              ),

              // Logout
              IconButton(
                onPressed: (){
                  global.privateKey = null;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                },
                icon: Icon(Icons.logout)
              ),

            ],
          ),
        ),

        Expanded(
          child: currentPage
        )

      ],
    );
  }
}