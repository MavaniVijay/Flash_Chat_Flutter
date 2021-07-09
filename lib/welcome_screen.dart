import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/roundedButton.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //3. A.c
  AnimationController controller; //1. A.C
  Animation animation; //8. create a Animation variable
  @override
  void initState() {
    //2. make a Initstate method and in controller
    // TODO: implement initState
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      //upperBound: 100.0, //5. upper bound indicator animation make ok
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    //animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller); //11. make a color tween animation in background color in animation.
    controller.forward(); //3.
    controller.addStatusListener((status) {
      //  print(status); //10. create the method addstatus listner and print this satuts. and if else condition.
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      //4. make a add listener controller
      setState(() {}); //4.
      // print(animation.value); //8. print menu changed in controller changed name is a animation
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset("images/logo.png"),
                    height: 60,
                    //height: animation.value *100, //7. make it controller.value in height Animation created   after //9.  and changed animation.controller
                  ),
                ),
                //code
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 50),
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Flash_Chats",
                  ],
                  textStyle: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            RoundedButton(
              title: "Log In",
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: "Register",
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
