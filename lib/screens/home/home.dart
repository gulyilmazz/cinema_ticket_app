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
              // Kenarlık rengi
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
          color: const Color.fromARGB(255, 10, 223, 223),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
                  // Kenarlık rengi
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
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal, // Yatay kaydırma
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(label: Text('Aksiyon')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(label: Text('Komedi')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(label: Text('Bilim Kurgu')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(label: Text('Dram')),
              ),
              // Daha fazla kategori ekleyebilirsiniz
            ],
          ),
        ),
        Expanded(child: Center(child: Text('Ana Sayfa İçeriği'))),
      ],
    );
  }
}
