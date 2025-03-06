import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Giriş ekranını içe aktar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uygulama Adı',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(), // Uygulama başlangıcında giriş ekranını göster
    );
  }
}
