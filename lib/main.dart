import 'package:cinemaa/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'screens/login_screen.dart'; // Giriş ekranını içe aktar

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sinemalarda..',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(), // Uygulama başlangıcında giriş ekranını göster
    );
  }
}
