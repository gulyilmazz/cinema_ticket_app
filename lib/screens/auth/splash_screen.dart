import 'package:cinemaa/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Arka plan gradient renkleri (açık ve koyu tonlar)
  static const Color gradientStart = Color.fromARGB(255, 15, 2, 10);
  static const Color gradientEnd = Color.fromARGB(255, 11, 155, 165);

  // Splash ekranında gösterilecek resmin boyutları
  static const double imageWidth = 200.0;
  static const double imageHeight = 300.0;

  // Splash ekranının kaç saniye görüneceği
  static const int splashDuration = 5;

  @override
  void initState() {
    super.initState();
    // 5 saniye bekleyip giriş ekranına yönlendirme yapıyorum
    Timer(
      //fonksiyonum
      Duration(seconds: splashDuration),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000), // Animasyon süresi
          pageBuilder:
              (context, animation, secondaryAnimation) => LoginScreen(),
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
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [gradientStart, gradientEnd], // Arka plan renk geçişi
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                // Splash ekranında gösterilecek GIF
                Image.asset(
                  'assets/images/perde.gif',
                  width: imageWidth,
                  height: imageHeight,
                ),
                // Hoşgeldiniz mesajı
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
            // Yükleme animasyonu göstermek için progress indicator
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
