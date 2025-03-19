import 'package:cinemaa/screens/filtreleme_secenekleri_sayfas%C4%B1.dart';
import 'package:flutter/material.dart';
import '../widgets/ana_cekmece.dart';
import '../models/film_model.dart';

class FilmTry extends StatefulWidget {
  @override
  _FilmTryState createState() => _FilmTryState();
}

class _FilmTryState extends State<FilmTry> {
  int _selectedIndex = 0; // Seçilen butonun indeksini tutar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Butonlara tıklandığında yapılacak işlemleri burada tanımlayın
    if (index == 1) {
      // Bilet Alım
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  FiltrelemeSecenekleriSayfasi(), // Filtreleme sayfasına yönlendir
        ),
      );
    } else if (index == 2) {
      // Ödeme
      // Ödeme sayfasına yönlendirme veya işlemleri burada gerçekleştirin
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vizyondaki Filmler'),
        backgroundColor: const Color.fromARGB(255, 31, 177, 187),
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FiltrelemeSecenekleriSayfasi(),
                ),
              );
            },
          ),*/
        ],
      ),
      drawer: AnaCekmece(),
      body: Container(
        color: const Color.fromARGB(255, 245, 238, 238),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //favori filmler
            icon: Icon(Icons.favorite_border_outlined),
            label: '',
          ),
          //ana sayfa
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_sharp),
            label: '',
          ),
          //bilet kısmı,filtreleme
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: const Color.fromARGB(255, 31, 177, 187),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _filmKarti(BuildContext context, Film film) {
    return Card(
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
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
