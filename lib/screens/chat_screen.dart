import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/constrain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String screenid = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggInuser;
  var messagetext;

  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

  void getCurrentuser() async {
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        loggInuser = user;
        print(loggInuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void streammessages() async {
    await for (var snapshots in _firestore.collection('messages').snapshots()) {
      for (var messages in snapshots.docs) {
        print(messages.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data?.docs;
                    List<bubblebutton> messageWigdets = [];
                    for (var message in messages ?? []) {
                      final messageText = message.get('text');
                      final messageSender = message.get('sender');

                      final messagesbubbles =
                      bubblebutton(text: messageText, sender: messageSender);

                      messageWigdets.add(messagesbubbles);
                    }
                    return Expanded(
                      child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                          children:messageWigdets
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      messageTextController.clear();
                      //using messagetext string + logginuser email to send data to database created
                      _firestore.collection('messages').add(
                          {'sender': loggInuser.email, 'text': messagetext});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class bubblebutton extends StatelessWidget {

  bubblebutton({required this.text,required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        Text(sender,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54
          ),
        ),
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
              ),
              ),
            )
        ),

        ]
      ),
    );
  }
}
