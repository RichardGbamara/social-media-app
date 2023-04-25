// ignore_for_file: library_private_types_in_public_api, file_names, await_only_futures, unnecessary_null_comparison, avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:webtech/Screens/PostScreen.dart';
import 'package:webtech/Screens/ProfilePage.dart';

import 'Edit_Profile_Screen.dart';

import 'ViewFeed.dart';

import 'package:firebase_auth/firebase_auth.dart';

var loggedInUser = FirebaseAuth.instance.currentUser;

class HomePage extends StatefulWidget {
  static String id = "home_screen";
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 8, 196),
        title: const Text('My App'),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(loggedInUser?.displayName ?? 'User Name'),
              accountEmail: Text(loggedInUser?.email ?? 'user@example.com'),
              currentAccountPicture: CircleAvatar(
                child: loggedInUser?.photoURL != null
                    ? ClipOval(
                        child: Image.network(loggedInUser!.photoURL!),
                      )
                    : const Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create Post'),
              onTap: () {
                //create function here
                Navigator.pushNamed(context, MainChatScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text('View Posts'),
              onTap: () {
                Navigator.pushNamed(context, FeedScreen.id);
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Image.asset(
        'images/Ashesi_Campus_5-min.jpg', // replace with your own image path
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MainChatScreen.id);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
