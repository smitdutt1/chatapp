import 'package:flutter/material.dart';
import 'package:chatapp/screens/welcome_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';


// void main() => runApp(chatapp());


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(chatapp());
}


class chatapp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: 'welcome_screen',
      routes: {
         WelcomeScreen.screenid: (context) => WelcomeScreen(),
         LoginScreen.screenid : (context) => LoginScreen(),
        RegistrationScreen.screenid : (context) => RegistrationScreen(),
        ChatScreen.screenid:(context) => ChatScreen(),
      },
    );
  }
}

