import 'package:cinemaa/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Color gradientStart = Color.fromARGB(255, 15, 2, 10);
  static const Color gradientEnd = Color.fromARGB(255, 11, 155, 165);
  static const double imageWidth = 200.0;
  static const double imageHeight = 300.0;
  static const int splashDuration = 7; // Splash ekranı süresi (saniye)

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: splashDuration),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [gradientStart, gradientEnd],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    'lib/assets/images/perde.gif',
                    width: imageWidth,
                    height: imageHeight,
                  ),
                  Text(
                    "Hoşgeldiniz",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                ],
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
