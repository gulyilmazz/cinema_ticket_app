import 'package:flutter/material.dart';
import '../../models/film_model.dart';
import '../../screens/movie/film_detail_screen.dart';

class FilmKarti extends StatelessWidget {
  final Film film;

  const FilmKarti({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmDetaySayfasi(film: film),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(film.resimYolu, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    film.baslik,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(film.aciklama, style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
