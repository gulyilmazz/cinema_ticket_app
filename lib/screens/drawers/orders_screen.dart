import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Siparişlerim'),
        backgroundColor: const Color.fromARGB(255, 221, 202, 30),
      ),
      body: Center(child: Text('Sipariş sayfam')),
    );
  }
}
