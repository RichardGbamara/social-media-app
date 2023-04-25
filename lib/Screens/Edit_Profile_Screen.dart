// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);

//   static String id = "hdhdhdhdhdhdhdhdhdkdhfjfhfjfhfhfjfhffhf";

//   @override
//   // ignore: library_private_types_in_public_api
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _auth = FirebaseAuth.instance;
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _firstNameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _lastNameController = TextEditingController();
//   TextEditingController _studentIdController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }

//   Future<void> _fetchUserData() async {
//     final response = await http.get(Uri.parse(
//         'https://us-central1-jonathan-cloud-func.cloudfunctions.net/ash-share/retrieve_user/${_auth.currentUser?.uid}'));
//     if (response.statusCode == 200) {
//       final userData = json.decode(response.body);
//       _firstNameController.text = userData['firstName'];
//       _lastNameController.text = userData['lastName'];
//       _emailController.text = userData['email'];
//       _studentIdController.text = userData['studentId'];
//     } else {
//       throw Exception('Failed to fetch user data');
//     }
//   }

//   Future<void> _updateUserData() async {
//     final response = await http.post(
//       Uri.parse(
//           'https://us-central1-jonathan-cloud-func.cloudfunctions.net/ash-share/update_user/${_auth.currentUser?.uid}'),
//       body: {
//         'firstName': _firstNameController.text.trim(),
//         'lastName': _lastNameController.text.trim(),
//         'email': _emailController.text.trim(),
//         'studentId': _studentIdController.text.trim(),
//       },
//     );
//     if (response.statusCode == 200) {
//       // ignore: use_build_context_synchronously
//       Navigator.pop(context, true);
//     } else {
//       throw Exception('Failed to update user data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Edit Profile'),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//                 key: _formKey,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextFormField(
//                         controller: _firstNameController,
//                         decoration: const InputDecoration(
//                           labelText: 'First Name',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your first name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         controller: _lastNameController,
//                         decoration: const InputDecoration(
//                           labelText: 'Last Name',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your last name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         controller: _studentIdController,
//                         decoration: const InputDecoration(
//                           labelText: 'Student ID',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your last name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ]))));
//   }
// }

// ignore_for_file: prefer_final_fields, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webtech/Screens/ProfilePage.dart';

import 'HomeScreen.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static String id = "hdhdhdhdhdhdhdhdhdkdhfjfhfjfhfhfjfhffhf";

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _studentIdController = TextEditingController();
  TextEditingController _bestFoodController = TextEditingController();
  TextEditingController _bestMovieController = TextEditingController();
  TextEditingController _yearGroupController = TextEditingController();
  TextEditingController _campusResidenceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://us-central1-jonathan-cloud-func.cloudfunctions.net/ash-share/retrieve_user/${_auth.currentUser?.uid}'));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      _firstNameController.text = userData['firstName'];
      _lastNameController.text = userData['lastName'];
      _emailController.text = userData['email'];
      _studentIdController.text = userData['studentId'];
      _bestFoodController.text = userData['bestFood'];
      _bestMovieController.text = userData['bestMovie'];
      _yearGroupController.text = userData['yearGroup'];
      _campusResidenceController.text = userData['hasCampusResidence'];
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  Future<void> _updateUserData() async {
    final data = jsonEncode({
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'studentId': _studentIdController.text.trim(),
      'yearGroup': _yearGroupController.text.trim(),
      'bestFood': _bestFoodController.text.trim(),
      'bestMovie': _bestMovieController.text.trim(),
      'hasCamPusResidence': _campusResidenceController.text.trim()
    });
    final response = await http.patch(
      Uri.parse(
          'https://us-central1-jonathan-cloud-func.cloudfunctions.net/ash-share/update_user/${_auth.currentUser?.uid}'),
      body: data,
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } else {
      throw Exception('Failed to update user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text('Edit Profile'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Emaill',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        controller: _studentIdController,
                        decoration: const InputDecoration(
                          labelText: 'Student ID',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
  
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _campusResidenceController,
                        decoration: const InputDecoration(
                          labelText: 'Has Campus Residence',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _bestMovieController,
                        decoration: const InputDecoration(
                          labelText: 'Best Movie',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _bestFoodController,
                        decoration: const InputDecoration(
                          labelText: 'best FOod ',
                        ),
                      ),
                      const SizedBox(height: 16),
                      MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _updateUserData();
                            Navigator.pushNamed(context, HomePage.id);
                          }
                        },
                        textColor: Colors.red,
                        child: const Text('Save Changes'),
                      )
                    ]))));
  }
}
