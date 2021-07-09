import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/chats_screen.dart';
import 'package:flash_chat/constant.dart';
import 'package:flash_chat/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool spinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
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
                    //code is here
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Email Address'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //code is here
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
                  title: "Log In",
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    //Go to Login Screen
                    // print(email);
                    // print(password);
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        spinner = false;
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
