import 'package:flutter/material.dart';
import '../../screens/alt_buton/films_home.dart'; // films_home.dart dosyasını import ediyoruz

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
      backgroundColor: const Color.fromARGB(
        255,
        126,
        168,
        11,
      ), // Arka plan rengi
      selectedItemColor: const Color.fromARGB(
        255,
        214,
        46,
        4,
      ), // Seçili öğe rengi
      unselectedItemColor: const Color.fromARGB(
        255,
        8,
        4,
        4,
      ), // Seçili olmayan öğe rengi
      type: BottomNavigationBarType.fixed, // Sabit genişlik
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
        // onTap özelliğini güncelliyoruz
        if (index == 1) {
          // "Filmler" butonuna tıklandıysa
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmsHome(),
            ), // films_home.dart'ı açıyoruz
          );
          widget.onItemTapped(index); // _selectedIndex'i güncelliyoruz
        } else {
          widget.onItemTapped(
            index,
          ); // Diğer butonlar için onItemTapped'i çağırıyoruz
        }
      },
    );
  }
}
