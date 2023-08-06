import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/welcomebuttonscreen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/constrain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginScreen extends StatefulWidget {

  static const String  screenid= 'login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  var email;
  var password;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logos',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: newtextfielddeco.copyWith(
                  hintText: 'Enter your email'
                )
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: newtextfielddeco.copyWith(
                  hintText: 'Enter your password'
                )
              ),
              SizedBox(
                height: 24.0,
              ),
              roundbutton(colour: Colors.lightBlueAccent,
                  title: 'Login', onpressed: () async{
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password
                    );

                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.screenid);
                    }
                  }
                  catch(e){
                    print(e);
                  }
                  finally{
                    setState(() {
                      spinner = false;

                    });
                  }
                  })

            ],
          ),
        ),
      ),
    );
  }
}