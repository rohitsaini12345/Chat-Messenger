import 'package:chatmessenger/utility/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Button_Round extends StatelessWidget {
  const Button_Round(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.color,
      this.isIcon = false})
      : super(key: key);
  final onPressed;
  final String title;
  final Color color;
  final bool isIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 5,
        color: color,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          height: 60,
          minWidth: 250,
          onPressed: onPressed,
          child: isIcon
              ? Icon(Icons.send)
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class TextEntry extends StatelessWidget {
  const TextEntry(
      {Key? key,
      this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      this.hintText = "",
      this.icon,
      this.controller,
      this.keepLeft = false})
      : super(key: key);

  final onChanged;
  final keyboardType;
  final bool obscureText;
  final hintText;
  final icon;
  final controller;
  final bool keepLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlign: keepLeft ? TextAlign.left : TextAlign.center,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: AppColors.primaryColor)),
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.primaryColor,
          ),
        ),
        cursorColor: AppColors.primaryColor,
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    this.onTap,
    this.username = "",
  }) : super(key: key);

  final onTap;
  final String username;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(225, Random().nextInt(225),
                      Random().nextInt(225), Random().nextInt(225)),
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(username),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.7,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, this.username = "", this.isMe = false, this.message = ""})
      : super(key: key);
  final String username;
  final bool isMe;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 60)
          : const EdgeInsets.only(top: 10, bottom: 10, right: 60, left: 10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(color: Colors.black38),
          ),
          Material(
            color: isMe ? AppColors.primaryColor : Colors.white30,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 2,
          )
        ],
      ),
    );
  }
}
