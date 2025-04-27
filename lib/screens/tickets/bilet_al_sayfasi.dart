import 'package:cinemaa/screens/bottoms/home.dart'; // Use the Film class from home.dart
import 'package:cinemaa/screens/tickets/bilets_screen.dart';
import 'package:flutter/material.dart';

class BiletAlSayfasi extends StatelessWidget {
  final Film film;

  const BiletAlSayfasi({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bilet Al: ${film.baslik}',
          style: TextStyle(
            color: const Color.fromARGB(255, 10, 223, 230),
            fontSize: 18,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 9, 14, 10),
                const Color.fromARGB(255, 118, 113, 167),
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 10, 223, 230),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 152, 147, 196),
              const Color.fromARGB(255, 211, 208, 218),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BiletsScreen(
          film: film,
          movieTitle: film.baslik,
          moviePoster: film.resimUrl,
        ),
      ),
    );
  }
}
