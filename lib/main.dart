import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webtech/Screens/HomeScreen.dart';
import 'package:webtech/Screens/PostScreen.dart';
import 'package:webtech/Screens/ProfilePage.dart';


import 'Screens/Edit_Profile_Screen.dart';
import 'Screens/ViewFeed.dart';
import 'Screens/login.dart';
import 'Screens/registration.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBPmIO9ZV1agP_DVuVsb2bI3a70lGU-nj4",
        authDomain: "ash-share.firebaseapp.com",
        projectId: "ash-share",
        storageBucket: "ash-share.appspot.com",
        messagingSenderId: "13107221402",
        appId: "1:13107221402:web:e06c5baaeaf9549e4da023"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        HomePage.id: (context) => const HomePage(),
        EditProfilePage.id: (context) => const EditProfilePage(),
        FeedScreen.id: (context) => const FeedScreen(),
        MainChatScreen.id: (context) => const MainChatScreen(),
        RegisterPage.id: (context) => const RegisterPage(),
        ProfilePage.id: (context) => const ProfilePage(),
      },
    );
  }
}
