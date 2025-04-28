import 'package:cinemaa/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart'; // Bunu ekle

//import 'screens/login_screen.dart'; // Giriş ekranını içe aktar

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null); // Türkçe için
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
