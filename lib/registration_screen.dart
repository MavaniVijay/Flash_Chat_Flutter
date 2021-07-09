import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constant.dart';
import 'package:flash_chat/roundedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'chats_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth =
      FirebaseAuth.instance; //15.6 create a variable and firebase.auth
  String email; //15.1 first step make a variable
  String password; //15.2 second step
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 100,
                ),
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset("images/logo.png"),
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //go to code       //15.3 email = value create a make
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Your Email Address')),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //go to code    //15.4 create a make
                    password = value;
                  },
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password'),
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  title: "Register",
                  colour: Colors.blueAccent,
                  onPressed: () async {
                    //Go to Register Screen
                    // print(email); //15.5 print this email and password.
                    // print(password);
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password:
                              password); //15.7 create a new user email and password and try and catch block it
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                      showDialog(
                        context: (context),
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Invalid Box?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                              'Invalid Username or Password. Please try again.'),
                          elevation: 5,
                          backgroundColor: Colors.white,
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: Colors.lightBlue,
                              child: Text("Closed"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
