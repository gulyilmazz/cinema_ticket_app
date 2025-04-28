import 'package:cinemaa/screens/bottoms/bilet_screen.dart';
import 'package:cinemaa/screens/bottoms/fav_screen.dart';
import 'package:cinemaa/screens/bottoms/filtreleme_secenekleri_sayfas%C4%B1.dart';
import 'package:cinemaa/screens/bottoms/profil_screen.dart';
import 'package:cinemaa/screens/main_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  BottomNavBar({required this.onItemTapped, required this.selectedIndex});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 63, 231, 209),
      selectedItemColor: const Color.fromARGB(255, 233, 219, 202),
      unselectedItemColor: const Color.fromARGB(255, 8, 4, 4),
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_filter_sharp),
          label: 'Filmler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_num_outlined),
          label: 'Biletler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favoriler',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      currentIndex: widget.selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0: // Ana Sayfa
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
            break;
          case 1: // Filmler
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FiltrelemeSecenekleriSayfasi(),
              ),
            );
            break;
          case 2: // Biletler
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BiletlerSayfasi()),
            );
            break;
          case 3: // Favoriler
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavScreen()),
            );
            break;
          case 4: // Profil
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilScreen()),
            );
            break;
        }
        widget.onItemTapped(index);
      },
    );
  }
}
