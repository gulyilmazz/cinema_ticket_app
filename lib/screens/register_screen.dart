import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  // Kullanıcıdan e-posta veya telefon bilgisi almak için kontrolcü
  final TextEditingController _emailController = TextEditingController();
  // Kullanıcıdan şifre almak için kontrolcü
  final TextEditingController _passwordController = TextEditingController();
  // Kullanıcıdan şifre doğrulama bilgisi almak için kontrolcü
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sayfanın üst kısmında bir başlık göstermek için AppBar
      appBar: AppBar(title: Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // E-posta veya telefon giriş alanı
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-posta veya Telefon'),
            ),
            // Şifre giriş alanı (gizli karakterlerle gösterilir)
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre'),
            ),
            // Şifre doğrulama giriş alanı (gizli karakterlerle gösterilir)
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre Doğrulama'),
            ),
            SizedBox(height: 20),
            // Kayıt ol butonu, tıklandığında kullanıcıyı giriş ekranına yönlendirir
            ElevatedButton(
              onPressed: () {
                // Kayıt işlemleri burada gerçekleştirilebilir
                // Başarılı kayıt sonrası giriş ekranına yönlendirme
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Kayıt Ol'),
            ),
            // Zaten hesabı olan kullanıcılar için giriş ekranına yönlendirme butonu
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Zaten hesabın var mı? Giriş yap"),
            ),
          ],
        ),
      ),
    );
  }
}
