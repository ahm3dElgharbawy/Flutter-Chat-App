import 'package:chatapp/constants/appColors.dart';
import 'package:chatapp/constants/appRoutes.dart';
import 'package:chatapp/view/widgets/customMessageStreem.dart';
import 'package:chatapp/view/widgets/messageBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  TextEditingController textController = TextEditingController();
  late User signedInUser;
  String? message;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Chat Room"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
                icon: Icon(Icons.logout),
                splashRadius: 20,
              ),
            ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomMessageStreem(),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Material(
                    color: Colors.white,
                    child: Container(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.face),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        minLines: 1,
                        controller: textController,
                        onChanged: (val) {
                          message = val;
                        },
                        decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: "Type your Message...",
                          hintStyle: TextStyle(
                            color: Color(0xff607D8B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Color(0xff607D8B)),
                        onPressed: () async {
                          if (message != null && message != "") {
                            textController.clear();
                            await _fireStore.collection("messages").add({
                              "content": message,
                              "sender": signedInUser.email,
                              "time": FieldValue.serverTimestamp()
                            });
                            message=null;
                          }
                        },
                        // splashRadius: 20,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
