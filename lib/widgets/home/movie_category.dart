import 'package:cinemaa/models/film_model.dart';
import 'package:cinemaa/screens/movie/film_detail_screen.dart';
import 'package:flutter/material.dart';

class MovieCategory extends StatelessWidget {
  final String kategori;

  const MovieCategory({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    List<Film> filmler = Film.getFilmsByCategory(kategori);

    return ListView(
      children: [
        _kategoriBolumu(context, 'Vizyondaki Filmler', filmler),
        _kategoriBolumu(context, 'Önerilen Filmler', filmler),
        _kategoriBolumu(context, 'Yakında', filmler),
      ],
    );
  }

  Widget _kategoriBolumu(
    BuildContext context,
    String baslik,
    List<Film> filmler,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            baslik,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        SizedBox(
          height: 185,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filmler.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Film detay sayfasına yönlendirme
                    _navigateToFilmDetail(context, filmler[index]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color.fromARGB(255, 10, 222, 230),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(filmler[index].resimUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        filmler[index].baslik,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Film detay sayfasına yönlendirme fonksiyonu
  void _navigateToFilmDetail(BuildContext context, Film film) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilmDetaySayfasi(film: film)),
    );
  }
}
