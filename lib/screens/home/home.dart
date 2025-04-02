import 'package:cinemaa/screens/bottoms/bilet_screen.dart';
import 'package:cinemaa/screens/bottoms/fav_screen.dart';
import 'package:cinemaa/screens/bottoms/filtreleme_secenekleri_sayfas%C4%B1.dart';
import 'package:cinemaa/screens/bottoms/profil_screen.dart';
import 'package:cinemaa/widgets/buttons/left_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AnaSayfaIcerigi(),
    FavScreen(),
    FiltrelemeSecenekleriSayfasi(),
    BiletlerSayfasi(),
    ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 152, 147, 196),
              const Color.fromARGB(255, 211, 208, 218),
            ],
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      appBar: AppBar(
        title: Text(''),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 10, 222, 230),
              width: 1.5,
            ),
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
      drawer: LeftDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 9, 14, 10),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 118, 113, 167),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_sharp),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Tickets',
          ),
        ],
      ),
    );
  }
}

class AnaSayfaIcerigi extends StatefulWidget {
  @override
  _AnaSayfaIcerigiState createState() => _AnaSayfaIcerigiState();
}

class _AnaSayfaIcerigiState extends State<AnaSayfaIcerigi> {
  bool _isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color.fromARGB(255, 10, 222, 230),
                  width: 1,
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 9, 14, 10),
                    const Color.fromARGB(255, 118, 113, 167),
                  ],
                ),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: const Color.fromARGB(255, 10, 222, 230),
                  ),
                  SizedBox(width: 8),
                  Text('Ara'),
                ],
              ),
            ),
          ),
        ),
        FilmKategorileri(),
      ],
    );
  }
}

class FilmKategorileri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kategoriBolumu(context, 'Vizyondaki Filmler'),
        _kategoriBolumu(context, 'Önerilen Filmler'),
        _kategoriBolumu(context, 'Yakında'),
      ],
    );
  }

  Widget _kategoriBolumu(BuildContext context, String baslik) {
    List<String> filmResimleri = [
      'assets/film1.jpg',
      'assets/film2.jpg',
      'assets/film3.jpg',
      'assets/film4.jpg',
      'assets/film5.jpg',
      'assets/film6.jpg',
      'assets/film7.jpg',
      'assets/film8.jpg',
      'assets/film9.jpg',
      'assets/film10.jpg',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            baslik,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 150, // Resimlerin yüksekliğini ayarlayın
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filmResimleri.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100, // Resimlerin genişliğini ayarlayın
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(filmResimleri[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
