import 'package:chatmessenger/screens/1_welcome_screen.dart';
import 'package:chatmessenger/screens/2_registration.dart';
import 'package:chatmessenger/screens/3_login.dart';
import 'package:chatmessenger/screens/4_chatselect.dart';
import 'package:chatmessenger/screens/5_chat.dart';
import 'package:chatmessenger/screens/6_userprofile.dart';
import 'package:chatmessenger/utility/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: RouteTable.welcome,
        debugShowCheckedModeBanner: false,
        routes: {
          RouteTable.welcome: (context) => Welcome_Screen(),
          RouteTable.login: ((context) => Login_Screen()),
          RouteTable.registered: (context) => Registration_Screen(),
          RouteTable.selectChat: (context) => ChatSelect_Screen(),
          RouteTable.chat: (context) => Chat_Screen(),
          RouteTable.Userprofile: (context) => Userprofile(),
        });
  }
}
