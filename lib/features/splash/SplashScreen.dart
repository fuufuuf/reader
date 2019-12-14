import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen() : super(key: GlobalObjectKey(SplashScreen));

  // Use global key to ensure it reparent when a group of loading happens
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color(0xFF2293DD),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox.fromSize(
            child: Image.asset('app_icon.png'),
            size: Size.square(150),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Text(
              "米良追书",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      )));
}
