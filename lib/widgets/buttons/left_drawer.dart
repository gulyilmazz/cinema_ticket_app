import 'package:cinemaa/screens/drawers/account_screen.dart';
import 'package:cinemaa/screens/drawers/orders_screen.dart';
import 'package:cinemaa/screens/drawers/settings_sreen.dart';
import 'package:flutter/material.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // Container ekledik
        decoration: BoxDecoration(
          // Container'a decoration ekledik
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 20, 20, 20), // Başlangıç rengi
              const Color.fromARGB(255, 50, 50, 50), // Bitiş rengi
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //MENU
            DrawerHeader(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 14, 10),
                      const Color.fromARGB(255, 118, 113, 167),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Menü',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 237, 240, 240),
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            //GİRİS
            ListTile(
              leading: Icon(
                Icons.person,
                color: const Color.fromARGB(255, 10, 222, 230),
              ),
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 14, 10),
                      const Color.fromARGB(255, 118, 113, 167),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Giriş',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 236, 238, 238),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountScreen()),
                );
              },
            ),
            //SİPARİŞLER
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: const Color.fromARGB(255, 10, 222, 230),
              ),
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 14, 10),
                      const Color.fromARGB(255, 118, 113, 167),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Favorilerim',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 251, 252, 252),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),
            //SİPARİŞLER
            ListTile(
              leading: Icon(
                Icons.shopping_bag_outlined,
                color: const Color.fromARGB(255, 10, 222, 230),
              ),
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 14, 10),
                      const Color.fromARGB(255, 118, 113, 167),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Siparişler',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 251, 252, 252),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),

            //kuponlarım
            ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: const Color.fromARGB(255, 10, 222, 230),
              ),
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 14, 10),
                      const Color.fromARGB(255, 118, 113, 167),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Kuponlarım',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 251, 252, 252),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),
            //kartlarım
            ListTile(
              leading: Icon(
                Icons.credit_card,
                color: const Color.fromARGB(255, 10, 222, 230),
              ),
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 14, 10),
                      const Color.fromARGB(255, 118, 113, 167),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Kartlarım',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 251, 252, 252),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),
            //AYARLAR
            ListTile(
              leading: Icon(
                Icons.settings,
                color: const Color.fromARGB(255, 10, 222, 230),
              ),
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 14, 10),
                      const Color.fromARGB(255, 118, 113, 167),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Ayarlar',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 234, 238, 238),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsSreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
