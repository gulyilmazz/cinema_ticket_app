//  Giriş Yap Butonu
import 'package:cinemaa/screens/home/home.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Kullanıcı giriş yaptıktan sonra film listesi ekranına gider.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 42, 43, 38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Text(
          'Giriş >',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
