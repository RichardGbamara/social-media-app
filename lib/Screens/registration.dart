// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webtech/Screens/HomeScreen.dart';
import 'API_CALLS.dart';

class RegisterPage extends StatefulWidget {
  static String id = "djdjdjdjdjdjdjdndjdjdddnhdjddddd";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _yearGroupController = TextEditingController();
  final _majorController = TextEditingController();
  final _hasCampusResidenceController = TextEditingController();
  final _bestFoodController = TextEditingController();
  final _bestMovieController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _studentIdController.dispose();
    _dateOfBirthController.dispose();
    _yearGroupController.dispose();
    _majorController.dispose();
    _hasCampusResidenceController.dispose();
    _bestFoodController.dispose();
    _studentIdController.dispose();
    _bestMovieController.dispose();
    super.dispose();
  }

  Map<String, String> getTextFromControllers() {
    return {
      'id': _auth.currentUser!.uid,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'dateOfBirth': _dateOfBirthController.text,
      'yearGroup': _yearGroupController.text,
      'major': _majorController.text,
      'hasCampusResidence': _hasCampusResidenceController.text,
      'bestFood': _bestFoodController.text,
      'bestMovie': _bestMovieController.text,
      'studentId': _studentIdController.text
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Create an Account',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _bestFoodController,
                    decoration: const InputDecoration(
                      labelText: 'Best Food ',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _bestMovieController,
                    decoration: const InputDecoration(
                      labelText: 'Favorite Movie',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _dateOfBirthController,
                    decoration: const InputDecoration(
                      labelText: 'Date OF Birth',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _studentIdController,
                    decoration: const InputDecoration(
                      labelText: 'Student ID',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _yearGroupController,
                    decoration: const InputDecoration(
                      labelText: 'Year Group',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _hasCampusResidenceController,
                    decoration: const InputDecoration(
                      labelText: 'Hostel Name',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _majorController,
              decoration: const InputDecoration(
                labelText: 'Major',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                //Implement registration functionality.

                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                  submitData(getTextFromControllers());
                  // ignore: unnecessary_null_comparison
                  if (newUser != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, HomePage.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
