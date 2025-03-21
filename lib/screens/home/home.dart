import 'package:cinemaa/screens/alt_buton/bilet_screen.dart';
import 'package:cinemaa/screens/alt_buton/fav_screen.dart';
import 'package:cinemaa/screens/alt_buton/filtreleme_secenekleri_sayfas%C4%B1.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:cinemaa/models/film_model.dart';
import 'package:cinemaa/widgets/home_widgets/film_karti.dart';
import 'package:cinemaa/widgets/home_widgets/kaydirmali_film_karti.dart';

class FilmTry extends StatefulWidget {
  @override
  _FilmTryState createState() => _FilmTryState();
}

class _FilmTryState extends State<FilmTry> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Favoriler sayfasına yönlendirme
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavorilerSayfasi()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FiltrelemeSecenekleriSayfasi()),
      );
    } else if (index == 2) {
      // Biletler sayfasına yönlendirme
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BiletlerSayfasi()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vizyondaki Filmler'),
        backgroundColor: const Color.fromARGB(255, 31, 177, 187),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: Film.filmler.length,
              itemBuilder: (context, index) {
                return KaydirmaliFilmKarti(film: Film.filmler[index]);
              },
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
          DotsIndicator(
            dotsCount: Film.filmler.length,
            position: _currentPage.toInt(),
            decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: const Color.fromARGB(255, 31, 177, 187),
            ),
            onTap: (position) {
              _pageController.animateToPage(
                position,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: Film.filmler.length,
                itemBuilder: (context, index) {
                  return FilmKarti(film: Film.filmler[index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
  /*_kaydirmaliFilm
  Widget _kaydirmaliFilmKarti(BuildContext context, Film film1) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(film1.resimYolu, fit: BoxFit.cover),
      ),
    );
  }*/

  /*filmKarti
  Widget _filmKarti(BuildContext context, Film film) {
    return Card(
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Film detay sayfasına yönlendirme
          Navigator.push(
            // filmlere tıklayınca acıklama acılıyor
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
  }*/

