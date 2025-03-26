import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesabım'),
        backgroundColor: const Color.fromARGB(255, 221, 202, 30),
      ),
      body: Center(child: Text('Hesap bilgilerim')),
    );
  }
}
