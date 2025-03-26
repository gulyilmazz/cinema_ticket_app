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
    AnaSayfaIcerigi(), FavScreen(), // Filmler
    FiltrelemeSecenekleriSayfasi(), // Sinemalar
    BiletlerSayfasi(), // Biletler
    ProfilScreen(), // Profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // Sayfa başlığı
        backgroundColor: const Color.fromARGB(255, 34, 206, 212),
      ),
      drawer: LeftDrawer(), // LeftDrawer widget'ını ekliyoruz
      body: _pages[_selectedIndex], // Doğru sayfayı göster
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filtrele',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Biletler',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class AnaSayfaIcerigi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Ana Sayfa İçeriği'));
  }
}
