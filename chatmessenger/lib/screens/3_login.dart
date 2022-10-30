import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatmessenger/utility/components.dart';
import 'package:chatmessenger/utility/constant.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

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
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    if (user != null) {
                      Navigator.pushNamed(context, RouteTable.selectChat);
                    }
                  } catch (err) {
                    debugPrint(err.toString());
                  }
                },
                title: "Login",
                color: AppColors.primaryColor),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("not registered?"),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
            ),
          ],
        ),
      ),
    );
  }
}
