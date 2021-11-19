import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_app1/screens/home_page.dart';
import 'package:social_app1/screens/login_page.dart';
import 'package:social_app1/screens/screens_export.dart';

import '_shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String splashScreenId = "SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);
  static const String router = "SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initialization() {
    if (UserPreferences.token.isEmpty) {
      Navigator.pushNamed(context, LoginPage.loginPageId);
    } else {
      Navigator.pushNamed(context, HomePage.homePageId);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      initialization();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
