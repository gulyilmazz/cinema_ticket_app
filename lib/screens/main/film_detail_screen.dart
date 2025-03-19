import 'package:flutter/material.dart';
import '../../models/film_model.dart';

class FilmDetaySayfasi extends StatelessWidget {
  final Film film;

  FilmDetaySayfasi({required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(film.baslik)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(film.resimYolu, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              film.baslik,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(film.aciklama, style: TextStyle(fontSize: 16)),
            // ... diğer detaylar
          ],
        ),
      ),
    );
  }
}
