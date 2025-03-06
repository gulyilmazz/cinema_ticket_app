import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_film_listesi.dart';
import '../utils/renkler.dart'; // Renkler sınıfını içe aktar

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.arkaPlanRengi, // Arka plan rengini ayarla
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              style: TextStyle(
                color: Renkler.metinRengi,
              ), // Metin rengini ayarla
              decoration: InputDecoration(
                labelText: 'E-posta veya Telefon',
                labelStyle: TextStyle(color: Renkler.metinRengi),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Renkler.metinRengi),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Renkler.butonRengi),
                ),
              ),
            ),
            TextField(
              controller: _passwordController,
              style: TextStyle(
                color: Renkler.metinRengi,
              ), // Metin rengini ayarla
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Şifre',
                labelStyle: TextStyle(color: Renkler.metinRengi),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Renkler.metinRengi),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Renkler.butonRengi),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Giriş doğrulama işlemleri
                // Başarılı giriş sonrası film listesi ekranına yönlendirme
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FilmListesi()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Renkler.butonRengi, // Buton rengini ayarla
              ),
              child: Text('Giriş', style: TextStyle(color: Renkler.metinRengi)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text(
                "Hesabın yok mu? Kayıt ol",
                style: TextStyle(color: Renkler.metinRengi),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
