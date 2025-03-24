import 'package:cinemaa/screens/alt_buton/bilet_screen.dart';
import 'package:cinemaa/screens/alt_buton/fav_screen.dart';
import 'package:cinemaa/screens/alt_buton/filtreleme_secenekleri_sayfası.dart';
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
      drawer: Drawer(
        // Drawer ekleme
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 31, 177, 187),
              ),
              child: Text(
                'Menü',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Ana Sayfa'),
              onTap: () {
                // Ana sayfaya yönlendirme veya başka bir işlem
                Navigator.pop(context); // Drawer'ı kapat
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AnaSayfa()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ayarlar'),
              onTap: () {
                // Ayarlar sayfasına yönlendirme veya başka bir işlem
                Navigator.pop(context); // Drawer'ı kapat
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AyarlarSayfasi()));
              },
            ),
            // İhtiyacınıza göre daha fazla ListTile ekleyebilirsiniz
          ],
        ),
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
              color: const Color.fromARGB(255, 111, 145, 148),
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
