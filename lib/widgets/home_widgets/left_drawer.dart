import 'package:flutter/material.dart';
import '../../screens/alt_buton/filtreleme_secenekleri_sayfası.dart';
import '../../screens/ayarlar_sayfası.dart';

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
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 126, 168, 11),
            ),
            child: Text(
              'Menü',
              style: TextStyle(
                color: const Color.fromARGB(255, 17, 0, 0),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Giriş'),
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
            leading: Icon(Icons.login),
            title: Text('Siparişler'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AyarlarSayfasi()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AyarlarSayfasi()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Geçmiş İşlemler'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AyarlarSayfasi()),
              );
            },
          ),
        ],
      ),
    );
  }
}
