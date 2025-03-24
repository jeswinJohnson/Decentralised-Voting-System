import 'package:http/http.dart' as http;

Map<String, dynamic> electionStatus() {
  http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

// Map<String, int> currentElectionTime() {}

// void currentElectionTime(updatedTime) {}

// List<String> operatorsList() {}

// void addOperator(operatorAddress) {

// }

// List<Map<String, dynamic>> candidateList() {}

void addVoter(votterInfo) {}
