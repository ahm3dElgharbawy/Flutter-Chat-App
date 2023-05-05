import 'package:chatapp/view/widgets/messageBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomMessageStreem extends StatefulWidget {
  // final Stream<QuerySnapshot<Object?>> streem;
  const CustomMessageStreem({super.key});

  @override
  State<CustomMessageStreem> createState() => _CustomMessageStreemState();
}

class _CustomMessageStreemState extends State<CustomMessageStreem> {
  final signedInUser = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection("messages").orderBy("time").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<GestureDetector> chat = [];
        if (!snapshot.hasData) {
          return Expanded(
            child: Center(child: CircularProgressIndicator(),)
          );
        }
        final messages = snapshot.data!.docs;
        for (var message in messages) {
          final messageContent = message['content'];
          final sender = message['sender'];
          chat.add(
            GestureDetector(
              onLongPress: (){
                message.reference.delete();
              },
              child: MessageBody(
                sender: sender,
                messageContent: messageContent,
                isMe: signedInUser!.email == sender,
              ),
            ),
          );
        }
    
        return Expanded(
          child: Scrollbar(
              thickness: 5, 
              radius: Radius.circular(20),
              scrollbarOrientation:
                  ScrollbarOrientation.left, 
              child: ListView(
                children: chat,
              )),
        );
      },
    );
  }
}
