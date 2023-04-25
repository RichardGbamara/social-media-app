// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

// ignore: unused_element
Future<void> submitData(Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse(
        'https://us-central1-jonathan-cloud-func.cloudfunctions.net/ash-share/register_user'),
    body: jsonEncode(data),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // Handle success
    // ignore: avoid_print
    print('Data sent successfully');
  } else {
    // Handle error
    // ignore: avoid_print
    print('Failed to send data');
  }
}

Future<List<String>> getUserEmails() async {
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  List<String> userEmails = [];
  for (var doc in snapshot.docs) {
    userEmails.add(doc.data()['email']);
    print(userEmails);
  }

  return userEmails;
}

Future<bool> sendMail() async {
  try {
    final response = await http.post(
      Uri.parse(
          'https://us-central1-jonathan-cloud-func.cloudfunctions.net/ash-share/send_email'),
      body: jsonEncode({
        'emails': await getUserEmails(),
        //'author': FirebaseAuth.instance.currentUser?.email
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
      return true;
    } else {
      // Email failed to send
      return false;
    }
  } catch (e) {
    // Handle any exceptions that occur during the HTTP request
    print('Failed to send email: $e');
    return false;
  }
}
