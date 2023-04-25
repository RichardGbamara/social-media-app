// // ignore_for_file: library_private_types_in_public_api, file_names

// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:firebase_auth/firebase_auth.dart';

//final _firestore = FirebaseFirestore.instance;
// var loggedInUser = FirebaseAuth.instance.currentUser;

// class MessageBubble extends StatefulWidget {
//   const MessageBubble({
//     Key? key,
//     required this.sender,
//     required this.text,
//     required this.isMe,
//     required time,
//   }) : super(key: key);

//   final String sender;
//   final String text;
//   final bool isMe;

//   @override
//   _MessageBubbleState createState() => _MessageBubbleState();
// }

// class _MessageBubbleState extends State<MessageBubble> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment:
//             widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             widget.sender,
//             style: const TextStyle(
//               fontSize: 12.0,
//               color: Colors.black54,
//             ),
//           ),
//           Material(
//             borderRadius: widget.isMe
//                 ? const BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     bottomLeft: Radius.circular(30.0),
//                     bottomRight: Radius.circular(30.0),
//                   )
//                 : const BorderRadius.only(
//                     bottomLeft: Radius.circular(30.0),
//                     bottomRight: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//             elevation: 5.0,
//             color: widget.isMe ? Colors.lightBlueAccent : Colors.white,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 widget.text,
//                 style: TextStyle(
//                   color: widget.isMe ? Colors.white : Colors.black54,
//                   fontSize: 15.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MessagesStream extends StatelessWidget {
//   static const id = 'messages_stream';
//   //static String id = "message_stram";
//   const MessagesStream({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('messages')
//           .orderBy('time', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlueAccent,
//             ),
//           );
//         }
//         final messages = snapshot.data?.docs.reversed;
//         List<MessageBubble> messageBubbles = [];
//         for (var message in messages!) {
//           final messageText = message.get('text');
//           final messageSender = message.get('sender');
//           final messageTime = message.get('time');

//           final currentUser = loggedInUser?.email;

//           final messageBubble = MessageBubble(
//               sender: messageSender,
//               text: messageText,
//               isMe: currentUser == messageSender,
//               time: messageTime);

//           messageBubbles.add(messageBubble);
//         }
//         return Expanded(
//
//   child: ListView(
//             reverse: true,
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//             children: messageBubbles,
//           ),
//         );
//       },
//     );
//   }
// }

class FeedScreen extends StatefulWidget {
  static const String id = 'feed_screen';

  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 169, 244),
        title: const Text('Feed'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final posts = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: posts?.length,
                    itemBuilder: (context, index) {
                      final post = posts![index];
                      return PostTile(post: post);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  final QueryDocumentSnapshot post;

  const PostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = post['sender'];
    final content = post['text'];
    final time = post['time'].toString();

    return Card(
      color: const Color.fromARGB(255, 250, 174, 246),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              time,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
