import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

final _firestore = FirebaseFirestore.instance;
User
    loggedInUser; //crate a User firestore in make a vaariable loginuser //23.1 loggin user a global firestore

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController =
      TextEditingController(); //22.7 create a textediting controller ok
  final _auth = FirebaseAuth.instance; //15.8 make a firebase auth create
  String messageText;
  String messageTime;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    //15.9 create a current user function.
    try {
      final user = await _auth.currentUser; //15.10 crate a make a current user
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email); //print this a email in run screen
      }
    } catch (e) {
      print(e);
    }
  }

  //MessageStream Function Make is a data check and id check from firebase upper and all data show
  // void messageStream() async {
  //   await for (var snapshort in _firestore.collection('message').snapshots()) {
  //     for (var message in snapshort.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

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
                //messageStream();
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
            // 21. episode All stream and stream builder is make create the final variable and return the column.
            //Show Screen data in chat screen and type message in add automatically chat screen.
            //22.6 Crate a class messageStream and return Stram Builder ok
            MessageStream(), //call message Stream ok
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller:
                          messageTextController, //22.8 controller put in here
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController
                          .clear(); //22.9 put messagetextcontroller.clear ok
                      _firestore.collection('message').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': DateTime.now(),
                      });
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

class MessageBubble extends StatelessWidget {
  //22.3 create a  make a class message bubble and 2 variable and paste here text widget. ok
  MessageBubble(
      {this.text,
      this.sender,
      this.isMe,
      this.time}); //23.2 create a variable isme name ok
  final String text;
  final String sender;
  final bool isMe;
  final Timestamp time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start, //23.8 is me use it bool variable ok
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black54),
          ),
          Material(
            //Material wrap widget is the column ok
            //23.9 create use it isme
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ), //23.3  borderradius change it means only avse
            elevation: 5,
            //23.6 is me bool create a variable
            color: isMe
                ? Colors.lightBlueAccent
                : Colors.white, //create a wrap widget is a material widget
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  //23.7 isme a use it
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('message').orderBy('time').snapshots(),
      builder: (context, snapshort) {
        if (!snapshort.hasData) {
          //code is here
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshort
            .data.docs.reversed; //23.11 create last ma .reveresed marvu
        List<MessageBubble> messageBubbles =
            []; //22.5 Text remove and <messagebubble> error is a clear in add.(messagebubble clear ok)
        for (var message in messages) {
          final messageText = message.data()['text']; //different data call
          final messageSender = message.data()['sender']; //different data call
          final messageTime = message.data()['time'];

          final currentUser = loggedInUser
              .email; //23.4 create a variable current user = logginuser.email karavo
          if (currentUser == messageSender) {
            //23.5
            //the message from login user
          }

          // 22.2 remove the text widget and create class messagebubble ok
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser ==
                messageSender, //23.6 is me ma write this current user == messagesender
            time: messageTime,
          ); // 22.4 call messagebubble  and this a new constructor messagesend and messagetext ok
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse:
                true, //23.10 create a reverese true because message chat for
            //22.1 create a column deleted and created the Listview ok
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
