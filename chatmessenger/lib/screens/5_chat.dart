import 'package:chatmessenger/utility/components.dart';
import 'package:chatmessenger/utility/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat_Screen extends StatefulWidget {
  const Chat_Screen({Key? key}) : super(key: key);

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  String _receiver = '';
  final _auth = FirebaseAuth.instance;
  late User currentUser;
  final _firestore = FirebaseFirestore.instance;
  String _typedText = '';
  TextEditingController msgController = TextEditingController();

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
        setState(() {
          currentUser = user;
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    if (arg != null) {
      setState(() {
        _receiver = arg['receiver'];
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat jet",
          style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        elevation: 20,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          MessageStream(
              sender: currentUser.email as String, receiver: _receiver),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextEntry(
                      hintText: "type your message here",
                      controller: msgController,
                      keepLeft: true,
                      onChanged: (val) {
                        setState(() {
                          _typedText = val;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Button_Round(
                        onPressed: () {
                          _firestore.collection('messages').add({
                            'receiver': _receiver,
                            'sender': currentUser.email,
                            'text': _typedText,
                            'createdAt': Timestamp.now(),
                          });
                          msgController.clear();
                          setState(() {});
                        },
                        title: "|>",
                        isIcon: true,
                        color: AppColors.primaryColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required this.sender,
    required this.receiver,
  }) : super(key: key);
  final String sender;
  final String receiver;

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('message').orderBy('createdAt').snapshots(),
      builder: ((context, snapshot) {
        List<Map> messageData = [];
        if (snapshot.hasData) {
          for (var data in snapshot.data!.docs) {
            var cData = data.data() as Map;
            String texter = cData['sender'];
            String rec = cData['receiver'];
            if (((texter == sender) && (rec == receiver)) ||
                ((texter == receiver) && (rec == sender))) {
              messageData.add({
                'isMe': texter == sender,
                'username': texter == receiver ? texter.split('@')[0] : 'you',
                'message': cData['text'],
              });
            }
          }
        }
        final allMessage = snapshot.data;
        return Expanded(
          child: messageData.isEmpty
              ? const Center(
                  child: Text('No Chat found'),
                )
              : ListView(children: <MessageBubble>[
                  for (var mapData in messageData)
                    MessageBubble(
                      username: mapData["username"],
                      isMe: mapData["isMe"],
                      message: mapData["message"],
                    )
                ]),
        );
      }),
    );
  }
}
