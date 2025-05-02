// register_button.dart
import 'package:flutter/material.dart';
import '../../screens/auth/register_screen.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //Kayıt ol butonu
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        );
      },
      child: Text(
        "Hesabın yok mu? Kayıt ol",
        style: TextStyle(color: const Color.fromARGB(255, 199, 195, 195)),
      ),
    );
  }
}
