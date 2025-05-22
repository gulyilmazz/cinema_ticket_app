import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Splash ekranının kaç saniye görüneceği
  static const int splashDuration = 3;
  late String token;

  void initToken() async {
    // Tokeni alıyorum
    token = await AuthStorage.getToken() ?? '';
  }

  @override
  void initState() {
    super.initState();
    initToken(); // Tokeni başlatıyorum

    Timer(
      //fonksiyonum
      Duration(seconds: splashDuration),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000), // Animasyon süresi
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  token == "" ? LoginScreen() : LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0); // Sağdan sola kayan animasyon
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQuery.of(context).size; // Ekran boyutlarını alıyorum
    return Scaffold(
      body: Container(
        width: screenSize.width, // Tam genişlik
        height: screenSize.height, // Tam yükseklik
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Appcolor.appBackgroundColor,
              Appcolor.darkGrey,
            ], // AppColor temasına göre arka plan renk geçişi
          ),
        ),
        child: Center(
          child: Lottie.asset(
            "assets/images/Animation1.json",
          ), // Resmi dolduracak şekilde ayarlıyorum
        ),
      ),
    );
  }
}
