import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:voter_app/global.dart' as global;
import 'dart:async';
import 'dart:convert';

Uri urlParser(endPoint) {
  return Uri.parse('http://localhost:3000/$endPoint');
}

Future<Map<String, dynamic>> getVoters() async {
  Response res = await http.get(urlParser("getVoters"));
  return jsonDecode(res.body);
}

Future<Map<String, dynamic>> getCandidates() async {
  Response res = await http.get(urlParser("getCandidates"));
  return jsonDecode(res.body);
}

Future<String> addVote(String voterId ,String partyName) async {

  if(global.privateKey == null){
    return "Login Please";
  }
  Response res = await http.post(urlParser("vote"), 
    headers: {
      "key": global.privateKey!,
      "Content-Type": "application/json"
    },
    body: json.encode({
      "voterId": voterId,
      "partyName": partyName
    })
  );

  return res.body;
}
