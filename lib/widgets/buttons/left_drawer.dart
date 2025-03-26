import 'package:cinemaa/screens/bottom_nav/orders_screen.dart';
import 'package:flutter/material.dart';
import '../../screens/drawer/filtreleme_secenekleri_sayfası.dart';
import '../../screens/bottom_nav/settings_sreen.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //MENU
          DrawerHeader(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  // Kenarlık rengi
                  color: const Color.fromARGB(255, 10, 222, 230),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(
                  15,
                ), // Kenarlık yuvarlaklığı
                gradient: LinearGradient(
                  // Arka plan rengi
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
                  color: const Color.fromARGB(255, 10, 222, 230),
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
                  width: 1.5,
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
                  color: const Color.fromARGB(255, 10, 222, 230),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FiltrelemeSecenekleriSayfasi(),
                ),
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
                  width: 1.5,
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
                  color: const Color.fromARGB(255, 10, 222, 230),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FiltrelemeSecenekleriSayfasi(),
                ),
              );
            },
          ),
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
                  width: 1.5,
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
                  color: const Color.fromARGB(255, 10, 222, 230),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FiltrelemeSecenekleriSayfasi(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
