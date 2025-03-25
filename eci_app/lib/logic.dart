import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Uri urlParser(endPoint){
  return Uri.parse('http://localhost:3000/$endPoint');
}

Future<Map<String, dynamic>> electionStatus() async {
  Response res = await http.get(urlParser("getElectionStatus"));
  return jsonDecode(res.body);
}

// Map<String, int> currentElectionTime() {}

// void currentElectionTime(updatedTime) {}

// List<String> operatorsList() {}

// void addOperator(operatorAddress) {

// }

// List<Map<String, dynamic>> candidateList() {}

void addVoter(votterInfo) {}
