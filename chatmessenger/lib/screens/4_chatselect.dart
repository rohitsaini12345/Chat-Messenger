import 'package:chatmessenger/utility/components.dart';
import 'package:chatmessenger/utility/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ChatSelect_Screen extends StatefulWidget {
  const ChatSelect_Screen({Key? key}) : super(key: key);

  @override
  State<ChatSelect_Screen> createState() => _ChatSelect_ScreenState();
}

class _ChatSelect_ScreenState extends State<ChatSelect_Screen> {
  List<String> users = [];
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;
  late User currentUser;
  final _firestore = FirebaseFirestore.instance;
  List allUser = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentUser();
  }

  void getcurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        var data = await _firestore
            .collection('chatuser')
            .where(
              'email',
              isNotEqualTo: currentUser.email,
            )
            .orderBy('email')
            .get();
        setState(() {
          currentUser = user;
          for (var d in data.docs) {
            users.add(d.data()['email']);
          }
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteTable.welcome, (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
        title: Text(
          "Chat jet",
          style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        leading: SizedBox(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        elevation: 20,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (String username in users)
              ChatCard(
                username: username,
                onTap: () {
                  Navigator.pushNamed(context, RouteTable.chat,
                      arguments: {'receiver': username});
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "profile",
          ),
        ],
        currentIndex: currentIndex,
        onTap: (ind) {
          if (ind != currentIndex) {
            if (ind == 0) {
              Navigator.pushNamed(context, RouteTable.selectChat);
            } else if (ind == 1) {
              Navigator.pushNamed(context, RouteTable.Userprofile);
            }
          }
        },
      ),
    );
  }
}
