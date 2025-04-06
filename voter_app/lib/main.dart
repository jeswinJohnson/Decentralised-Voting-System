import 'package:flutter/material.dart';
import 'package:voter_app/logic.dart';
import 'global.dart' as global;
import 'package:get/get.dart';

void main() => runApp(const VotersApp());

class VotersApp extends StatelessWidget {
  const VotersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Voters App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 94, 150, 206),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

TextEditingController privateKeyController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    login(){
      if(privateKeyController.text == ""){
        Get.snackbar(
          "Title",
          "Private Key Cannot be Empty!",
          snackPosition: SnackPosition.BOTTOM,
        );
      }else{
        global.privateKey = privateKeyController.text;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VoterSelectionPage()));
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Private Key",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextField(
              controller: privateKeyController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("Sync System"),
            ),
          ],
        ),
      ),
    );
  }
}

class VoterSelectionPage extends StatefulWidget {
  const VoterSelectionPage({super.key});

  @override
  State<VoterSelectionPage> createState() => _VoterSelectionPageState();
}

List<Map<String, dynamic>> allVoters = [];

class _VoterSelectionPageState extends State<VoterSelectionPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> displayedVoters = [];
  int loadedCount = 10;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    displayedVoters = allVoters.take(loadedCount).toList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        loadMoreVoters();
      }
    });

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
        filterVoters();
      });
    });
  }

  void loadMoreVoters() {
    if (loadedCount >= allVoters.length) return;
    setState(() {
      loadedCount = (loadedCount + 10).clamp(0, allVoters.length);
      filterVoters();
    });
  }

  void filterVoters() {
    final filtered =
        allVoters
            .where(
              (voter) => voter['name']!.toLowerCase().contains(searchQuery),
            )
            .take(loadedCount)
            .toList();

    setState(() {
      displayedVoters = filtered;
    });
  }

  void toggleVoterSelection(int index) {
    if (displayedVoters[index]['hasVoted']) return;

    setState(() {
      for (var voter in allVoters) {
        voter['selected'] = false;
      }
      displayedVoters[index]['selected'] = true;
      allVoters.firstWhere(
            (v) => v['id'] == displayedVoters[index]['id'],
          )['selected'] =
          true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedVoter = allVoters.firstWhere(
      (voter) => voter['selected'] == true,
      orElse: () => {'id': null},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Voter'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Voters',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: getVoters(),
            builder: (context, Snapshot) {

              if(Snapshot.connectionState != ConnectionState.done){
                return CircularProgressIndicator();
              }

              if(Snapshot.data == null){
                return Text("Error Occured");
              }

              Map voterList = Snapshot.data!;
                
              voterList["voters"].forEach((voter) => {
                displayedVoters.add({
                  "id": voter["id"],
                  "name": voter["name"],
                  'selected': false,
                  'hasVoted': false
                })
              });

              allVoters = displayedVoters;


              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: displayedVoters.length,
                  itemBuilder: (context, index) {
                    final voter = displayedVoters[index];
                    final hasVoted = voter['hasVoted'] as bool;
                    final isSelected = voter['selected'] as bool;
              
                    return Card(
                      color:
                          hasVoted
                              ? Colors.grey[300]
                              : isSelected
                              ? Colors.green[100]
                              : null,
                      child: ListTile(
                        enabled: !hasVoted,
                        leading: Icon(
                          hasVoted
                              ? Icons.check_circle_outline
                              : isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color:
                              hasVoted
                                  ? Colors.grey
                                  : isSelected
                                  ? Colors.green
                                  : null,
                        ),
                        title: Text(voter['name']),
                        subtitle: Text('ID: ${voter['id']}'),
                        trailing:
                            hasVoted
                                ? const Chip(
                                  label: Text(
                                    'Voted',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.grey,
                                )
                                : null,
                        onTap: () => toggleVoterSelection(index),
                      ),
                    );
                  },
                ),
              );
            }
          ),
          if (selectedVoter['id'] != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Divider(),
                  Text(
                    'Selected Voter: ${selectedVoter['name']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            allVoters.firstWhere(
                                  (v) => v['id'] == selectedVoter['id'],
                                )['selected'] =
                                false;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      PartySelectionPage(voter: selectedVoter),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PartySelectionPage extends StatefulWidget {
  final Map<String, dynamic> voter;
  const PartySelectionPage({super.key, required this.voter});

  @override
  State<PartySelectionPage> createState() => _PartySelectionPageState();
}

final List<Map<String, String>> parties = [];

class _PartySelectionPageState extends State<PartySelectionPage> {

  String? selectedPartyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Party')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text('Voter: ${widget.voter['name']}'),
              subtitle: Text('ID: ${widget.voter['id']}'),
            ),
          ),
          FutureBuilder(
            future: getCandidates(),
            builder: (context, snapShot) {

              if(snapShot.connectionState != ConnectionState.done){
                return CircularProgressIndicator();
              }

              if(snapShot.data == null){
                return Text("Error Occured");
              }

              Map voterList = snapShot.data!;
                
              voterList["candidates"].forEach((voter) => {
                parties.add({
                  'id': '_',
                  'name': voter, 
                  'symbol': 'α'
                })
              });

              return Expanded(
                child: ListView.builder(
                  itemCount: parties.length,
                  itemBuilder: (context, index) {
                    final party = parties[index];
                    final isSelected = selectedPartyId == party['id'];
              
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      color: isSelected ? Colors.blue[50] : null,
                      child: ListTile(
                        leading: CircleAvatar(child: Text(party['symbol']!)),
                        title: Text(party['name']!),
                        trailing:
                            isSelected
                                ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                                : null,
                        onTap: () {
                          setState(() {
                            selectedPartyId = party['id'];
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            }
          ),
          if (selectedPartyId != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => setState(() => selectedPartyId = null),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final selectedParty = parties.firstWhere(
                        (party) => party['id'] == selectedPartyId,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ConfirmationPage(
                                voter: widget.voter,
                                party: selectedParty,
                              ),
                        ),
                      );
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> voter;
  final Map<String, String> party;

  const ConfirmationPage({super.key, required this.voter, required this.party});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Vote')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Color(0xFF10B981),
            ),
            const SizedBox(height: 20),
            Text('Voter: ${voter['name']}\nID: ${voter['id']}'),
            const SizedBox(height: 20),
            Text('Party: ${party['name']}\nID: ${party['id']}'),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    print("Voting");
                    await addVote(voter["id"], party['name']!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ThankYouPage(voter: voter),
                      ),
                    );
                  },
                  child: const Text('Confirm Vote'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThankYouPage extends StatelessWidget {
  final Map<String, dynamic> voter;
  const ThankYouPage({super.key, required this.voter});

  @override
  Widget build(BuildContext context) {
    voter['hasVoted'] = true;
    voter['selected'] = false;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: Color(0xFF10B981),
              ),
              const SizedBox(height: 20),
              const Text(
                'Thank You for Voting!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VoterSelectionPage(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Back to Voter List'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text('Logout to Login Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}