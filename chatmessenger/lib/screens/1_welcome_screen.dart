import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatmessenger/utility/components.dart';
import 'package:chatmessenger/utility/constant.dart';
import 'package:flutter/material.dart';

class Welcome_Screen extends StatefulWidget {
  const Welcome_Screen({Key? key}) : super(key: key);

  @override
  State<Welcome_Screen> createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<Welcome_Screen>
    with SingleTickerProviderStateMixin {
  late AnimationController Controller;
  late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = ColorTween(
      begin: Colors.red,
      end: Colors.white,
    ).animate(Controller);

    Controller.forward();
    Controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Container(
                    height: 90, child: Image.asset("assets/logo.png")),
              ),
              // Text('My_Chat'),
              //
              AnimatedTextKit(animatedTexts: [
                TyperAnimatedText("chat jet",
                    textStyle: TextStyle(
                      fontSize: 30,
                      color: AppColors.primaryColor,
                    ),
                    speed: Duration(milliseconds: 100)),
              ])
            ],
          ),
          Button_Round(
            onPressed: () {
              Navigator.pushNamed(context, RouteTable.login);
            },
            title: "Login",
            color: AppColors.primaryColor,
          ),
          Button_Round(
            onPressed: () {
              Navigator.pushNamed(context, RouteTable.registered);
            },
            title: "Register",
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
