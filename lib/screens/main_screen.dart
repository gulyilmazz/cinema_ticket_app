import 'package:cinemaa/screens/profil/profil_screen.dart';
import 'package:cinemaa/screens/tickets/bilet_screen.dart';
import 'package:cinemaa/screens/favorites/fav_screen.dart';
import 'package:cinemaa/screens/home/home.dart';
import 'package:cinemaa/widgets/buttons/left_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Sayfaları düzgün sırayla listeliyoruz
  final List<Widget> _pages = [
    HomeScreen(),
    FavScreen(),
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      appBar: AppBar(
        title: const Text(
          'Cinemaa',
          style: TextStyle(
            color: Color.fromARGB(255, 10, 223, 230),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // Şehir seçim butonu
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                _showSehirSecimDialog(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: const Color.fromARGB(255, 10, 223, 230),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'İstanbul',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 10, 223, 230),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
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
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 10, 223, 230),
        unselectedItemColor: Colors.grey,
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
            label: 'Biletler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Şehir seçim dialog penceresi
  void _showSehirSecimDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 9, 14, 10),
                  const Color.fromARGB(255, 118, 113, 167),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 10, 222, 230),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Şehir Seçin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                _buildSehirButton(context, 'İstanbul'),
                _buildSehirButton(context, 'Ankara'),
                _buildSehirButton(context, 'İzmir'),
                _buildSehirButton(context, 'Bursa'),
                _buildSehirButton(context, 'Antalya'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSehirButton(BuildContext context, String sehir) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$sehir seçildi')));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              sehir,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
