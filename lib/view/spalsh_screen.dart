import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shopzler/view/control_view.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ControlView();
            },
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Image.asset(
                    'assets/splash.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
