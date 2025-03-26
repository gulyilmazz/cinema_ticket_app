// kaydirmali_film_karti.dart (movie_widgets klasöründe)
import 'package:flutter/material.dart';
import '../../models/film_model.dart';

class KaydirmaliFilmKarti extends StatelessWidget {
  final Film film;

  KaydirmaliFilmKarti({required this.film});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(film.resimYolu, fit: BoxFit.cover),
      ),
    );
  }
}
