import 'package:cinemaa/screens/alt_buton/bilet_screen.dart';
import 'package:cinemaa/screens/alt_buton/fav_screen.dart';
import 'package:cinemaa/screens/alt_buton/filtreleme_secenekleri_sayfası.dart';
import 'package:cinemaa/screens/alt_buton/profil_screen.dart';
import 'package:cinemaa/screens/alt_buton/films_home.dart';
import 'package:cinemaa/widgets/home_widgets/bottom_nav_bar.dart';
import 'package:cinemaa/widgets/home_widgets/left_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    FilmsHome(), // Ana Sayfa
    FavorilerSayfasi(), // Filmler
    FiltrelemeSecenekleriSayfasi(), // Sinemalar
    BiletlerSayfasi(), // Biletler
    ProfilScreen(), // Profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'), // Sayfa başlığı
        backgroundColor: const Color.fromARGB(255, 126, 168, 11),
      ),
      drawer: LeftDrawer(), // LeftDrawer widget'ını ekliyoruz
      body:
          _selectedIndex == 0
              ? AnaSayfaIcerigi()
              : _pages[_selectedIndex], // Doğru sayfayı göster
      bottomNavigationBar: BottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
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
