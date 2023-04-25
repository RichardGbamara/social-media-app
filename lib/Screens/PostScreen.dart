//ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webtech/Screens/API_CALLS.dart';

class MainChatScreen extends StatefulWidget {
  static String id = "wowjdjhdhdbdhdhdh";
  const MainChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MainChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _loggedInUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(80, 65, 155, 150),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(206, 11, 23, 185),
        title: const Text('Feed'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final String messageText = _messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      FirebaseFirestore.instance.collection('messages').add({
                        'text': messageText,
                        'sender': _loggedInUser.email,
                        'time': DateTime.now().toString(),
                      }).then((value) async {
                        await sendMail();
                        print('email sent');
                        _messageController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
