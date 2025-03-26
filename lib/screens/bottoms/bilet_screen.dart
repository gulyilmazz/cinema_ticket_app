import 'package:flutter/material.dart';

class BiletlerSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biletler'),
        backgroundColor: const Color.fromARGB(255, 221, 202, 30),
      ),
      body: Center(child: Text('Biletleriniz Burada')),
    );
  }
}
