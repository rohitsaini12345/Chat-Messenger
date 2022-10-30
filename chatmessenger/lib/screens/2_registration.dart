import 'package:chatmessenger/utility/components.dart';
import 'package:chatmessenger/utility/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration_Screen extends StatefulWidget {
  const Registration_Screen({Key? key}) : super(key: key);

  @override
  State<Registration_Screen> createState() => _Registration_ScreenState();
}

class _Registration_ScreenState extends State<Registration_Screen> {
  String _email = '';
  String _password = '';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Hero(
                tag: "logo",
                child: Container(
                    height: 90, child: Image.asset("assets/logo.png")),
              ),
            ),
            TextEntry(
              onChanged: (val) {
                setState(() {
                  _email = val;
                });
              },
              icon: Icons.email,
              hintText: "email",
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            TextEntry(
              onChanged: (val) {
                setState(() {
                  _password = val;
                });
              },
              icon: Icons.key,
              hintText: "Password",
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
            ),
            Button_Round(
                onPressed: () async {
                  // debugPrint(_email);

                  // debugPrint(_password);
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: _email, password: _password);
                    if (newUser != null) {
                      _firestore.collection('chatuser').add({
                        'email': _email,
                        'username': '',
                      });
                      Navigator.pushNamed(context, RouteTable.selectChat);
                    }
                  } catch (err) {
                    debugPrint(err.toString());
                  }
                },
                title: "Register",
                color: AppColors.primaryColor),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("already registered?"),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
            ),
          ],
        ),
      ),
    );
  }
}
