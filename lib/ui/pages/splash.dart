import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';



class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: SplashScreen(
          seconds: 50,
          title: new Text(
            'Shoppesta Store',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          image: new Image.asset('assets/1.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 60.0,
          onClick: () => print("Flutter Egypt"),
          loaderColor: Colors.black45,
        ),
      ),
    );
  }
}
