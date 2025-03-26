import 'package:flutter/material.dart';

class SettingsSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
        backgroundColor: const Color.fromARGB(255, 221, 202, 30),
      ),
      body: Center(child: Text('Ayarlar Sayfası')),
    );
  }
}
