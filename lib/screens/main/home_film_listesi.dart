import 'package:cinemaa/screens/main/film_detail_screen.dart';
import 'package:cinemaa/screens/main/filtreleme_secenekleri_sayfas%C4%B1.dart';
import 'package:flutter/material.dart';
import '../../widgets/drawer_screen.dart';
import '../../models/film_model.dart';
import 'package:dots_indicator/dots_indicator.dart';

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

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FiltrelemeSecenekleriSayfasi()),
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

      //
      drawer: AnaCekmece(),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: 385,
            child: PageView.builder(
              //bu widget ile yatay kaydırma
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: Film.filmler.length,
              itemBuilder: (context, index) {
                return _kaydirmaliFilmKarti(context, Film.filmler[index]);
              },
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
          DotsIndicator(
            //bu widget ile sayfaları kaydırdım üsttekini
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
                  return _filmKarti(context, Film.filmler[index]);
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

  Widget _kaydirmaliFilmKarti(BuildContext context, Film film1) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(film1.resimYolu, fit: BoxFit.cover),
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
  }
}
