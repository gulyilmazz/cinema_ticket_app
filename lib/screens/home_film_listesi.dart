import 'package:cinemaa/screens/filtreleme_secenekleri_sayfası.dart';
import 'package:flutter/material.dart';
import '../widgets/ana_cekmece.dart';
import '../models/film.dart';
import 'package:cinemaa/utils/renkler.dart';

class FilmListesi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vizyondaki Filmler'),
        backgroundColor: Renkler.baslikArkaPlanRengi, // Renk kullanımı
        // AppBar arka plan rengi
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FiltrelemeSecenekleriSayfasi(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: AnaCekmece(),
      body: Container(
        // GridView.builder'ı Container içine al
        color: Renkler.filmListesiArkaPlanRengi, // Renk kullanımı
        // GridView.builder arka plan rengi
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: Film.filmler.length,
          itemBuilder: (context, index) {
            return _filmKarti(context, Film.filmler[index]);
          },
        ),
      ),
    );
  }

  Widget _filmKarti(BuildContext context, Film film) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Film detay sayfasına yönlendirme
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Image.asset(film.resimYolu, fit: BoxFit.cover)),
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
