// password_input.dart
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  PasswordInput({required this.controller, required this.focusNode});

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller, // Şifreyi kontrol eder.
      focusNode: widget.focusNode,
      obscureText: !_passwordVisible, // Şifreyi gizler veya gösterir.
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 149, 223, 223)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 203, 217, 229),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.lock, color: Colors.grey), // Kilit ikonu
        // Şifreyi göster/gizle butonu
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
}
