import 'package:flutter/material.dart';
import '../screens/filtreleme_secenekleri_sayfası.dart';
import '../screens/ayarlar_sayfası.dart';

class AnaCekmece extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 146, 14),
            ),
            child: Text(
              'Menü',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('wdsas'),
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
            title: Text('Giriş Yap'),
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
            title: Text('Biletlerim'),
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
