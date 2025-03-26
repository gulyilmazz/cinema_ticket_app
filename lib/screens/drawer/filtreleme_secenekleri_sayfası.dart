import 'package:flutter/material.dart';

class FiltrelemeSecenekleriSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtreleme Seçenekleri'), // Başlık eklendi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _filtrelemeSecenekleri('Şehir Seçiniz'),
            _filtrelemeSecenekleri('Mekan Seçiniz'),
            _filtrelemeSecenekleri('Tür Seçiniz'),
            _filtrelemeSecenekleri('Etkinlik Tarihi Seçiniz'),
          ],
        ),
      ),
    );
  }

  Widget _filtrelemeSecenekleri(String baslik) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(baslik), Icon(Icons.arrow_drop_down)],
      ),
    );
  }
}
