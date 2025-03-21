import 'package:cinemaa/screens/ayarlar_sayfas%C4%B1.dart';
import 'package:cinemaa/screens/movie/film_list_screen.dart';
import 'package:cinemaa/screens/movie/kullanici_bilgi_screen.dart';
import 'package:flutter/material.dart';

class AltNavigasyonCubugu extends StatefulWidget {
  @override
  _AltNavigasyonCubuguState createState() => _AltNavigasyonCubuguState();
}

class _AltNavigasyonCubuguState extends State<AltNavigasyonCubugu> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    FilmListScreen(), // Film listesi sayfası
    KullaniciBilgiScreen(), // Kullanıcı bilgileri sayfası
    AyarlarSayfasi(), // Ayarlar sayfası
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Filmler'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ayarlar'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
