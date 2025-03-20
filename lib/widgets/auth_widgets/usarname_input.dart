import 'package:flutter/material.dart';

class UsarnameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  UsarnameInput({required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    // Kullanıcı Adı (Username) Giriş Alanı
    return Column(
      children: [
        TextField(
          controller: controller, // Kullanıcı adını kontrol eder.
          focusNode: focusNode,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 3, 12, 19),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.grey,
            ), // Kullanıcı ikonu
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
