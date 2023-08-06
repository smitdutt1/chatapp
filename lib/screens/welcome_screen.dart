import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/screens/welcomebuttonscreen.dart';


class WelcomeScreen extends StatefulWidget {


  static const String  screenid= 'welcome_screen';


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logos',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('ZAPPER',
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    )
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            roundbutton(
              colour: Colors.lightBlueAccent,
              title: 'Log in',
              onpressed: (){
                Navigator.pushNamed(context, LoginScreen.screenid);
              } ,),
            roundbutton(colour: Colors.blueAccent,
                title: 'Register',
                onpressed: (){
                  Navigator.pushNamed(context, RegistrationScreen.screenid);
                }
            )
          ],
        ),
      ),
    );
  }
}

