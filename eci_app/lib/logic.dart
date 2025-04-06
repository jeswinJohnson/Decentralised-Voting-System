import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:eci_app/global.dart' as global;

Uri urlParser(endPoint){
  return Uri.parse('http://localhost:3000/$endPoint');
}

Future<Map<String, dynamic>> electionStatus() async {
  Response res = await http.get(urlParser("getElectionStatus"));
  return jsonDecode(res.body);
}

Future<Map<String, dynamic>> getOperators() async {
  Response res = await http.get(urlParser("getOperators"));
  return jsonDecode(res.body);
}

Future<Map<String, dynamic>> getCandidates() async {
  Response res = await http.get(urlParser("getCandidates"));
  return jsonDecode(res.body);
}

Future<Map<String, dynamic>> electionTime() async {
  Response res = await http.get(urlParser("getElectionTime"));
  return jsonDecode(res.body);
}

Future<String> updateTime(DateTime updateStart, DateTime updateEnd) async {

  if(global.privateKey == null){
    return "Login Please";
  }
  Response res = await http.post(urlParser("updateElectionTime"), 
    headers: {
      "key": global.privateKey!,
      "Content-Type": "application/json"
    },
    body: json.encode({
      "startTime": (updateStart.millisecondsSinceEpoch/1000).toString(),
      "endTime": (updateEnd.millisecondsSinceEpoch / 1000).toString(),
    })
  );

  return res.body;
}

Future<String> addParty(String partyName) async {

  if(global.privateKey == null){
    return "Login Please";
  }
  Response res = await http.post(urlParser("addCandidate"), 
    headers: {
      "key": global.privateKey!,
      "Content-Type": "application/json"
    },
    body: json.encode({
      "partyName": partyName,
    })
  );

  return res.body;
}

Future<String> addOperator(String operatorId) async {

  if(global.privateKey == null){
    return "Login Please";
  }
  Response res = await http.post(urlParser("addOperator"), 
    headers: {
      "key": global.privateKey!,
      "Content-Type": "application/json"
    },
    body: json.encode({
      "operatorId": operatorId,
    })
  );

  return res.body;
}

Future<String> addVoter(votterName, votterId) async {

  if(global.privateKey == null){
    return "Login Please";
  }
  Response res = await http.post(urlParser("addVoter"), 
    headers: {
      "key": global.privateKey!,
      "Content-Type": "application/json"
    },
    body: json.encode({
      "votterName": votterName,
      "votterId": votterId,
    })
  );

  return res.body;
}
