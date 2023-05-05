import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class MessageBody extends StatelessWidget {
  final String messageContent;
  final String sender;
  final bool isMe;
  const MessageBody(
      {super.key,
      required this.sender,
      required this.messageContent,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 11),
          ),
          ClipPath(
            clipper: isMe?UpperNipMessageClipperTwo(MessageType.send):UpperNipMessageClipperTwo(MessageType.receive),
            child: Container(
              color: isMe ? Colors.red : Colors.blue,
              padding: isMe?EdgeInsets.only(top: 10,right: 25 ,left: 10,bottom: 10):EdgeInsets.only(top: 10,right: 10 ,left: 25,bottom: 10),
              child: Text(
                messageContent,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
