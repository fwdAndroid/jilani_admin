import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jilani_admin/utils/color.dart';

import 'screen/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (builder) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/logo.png"),
          )),
        ],
      ),
    );
  }
}
