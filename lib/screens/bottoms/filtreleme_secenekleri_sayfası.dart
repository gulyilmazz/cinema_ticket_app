import 'package:flutter/material.dart';

class FiltrelemeSecenekleriSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ve body'yi Scaffold içinde tanımladık
      appBar: AppBar(
        title: Text('Filtreleme Seçenekleri'),
        backgroundColor: Color.fromARGB(255, 13, 17, 0),
      ),

      // Body kısmında arka plan rengi ve gradient uyguladık
      // Ayrıca içeriği bir Column içinde düzenledik
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 20, 20, 20),
              const Color.fromARGB(255, 50, 50, 50),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _filtrelemeSecenegi(
                context,
                'Şehir Seçiniz',
                yaziRengi: Colors.white,
              ),
              _filtrelemeSecenegi(
                context,
                'Mekan Seçiniz',
                yaziRengi: Colors.white,
              ),
              _filtrelemeSecenegi(
                context,
                'Tür Seçiniz',
                yaziRengi: Colors.white,
              ),
              _filtrelemeSecenegi(
                context,
                'Etkinlik Tarihi Seçiniz',
                yaziRengi: Colors.white,
              ),
              _filtrelemeSecenegi(
                context,
                'Etkinlik Saati Seçiniz',
                yaziRengi: Colors.white,
              ),

              SizedBox(height: 50), // Butonlar için boşluk ekledim
              ElevatedButton(
                // Film Listesi butonu
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilmListesiSayfasi(),
                    ),
                  );
                },

                // ElevatedButton yerine Container kullandım
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // İç boşluğu kaldırdık
                  shape: RoundedRectangleBorder(
                    // Kenarları yuvarladık
                    side: BorderSide(
                      // Kenar çizgisi rengi
                      color: const Color.fromARGB(255, 118, 113, 167),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // İçerik olarak Container kullandık
                // Gradient arka plan uyguladık
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 5, 5, 10),
                        Color.fromARGB(255, 7, 85, 85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    'Film Listesi',
                    style: TextStyle(
                      color: Color.fromARGB(255, 233, 222, 222),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filtrelemeSecenegi(
    BuildContext context,
    String baslik, {
    Color yaziRengi = Colors.black,
  }) {
    return GestureDetector(
      onTap: () {
        print('$baslik seçildi.');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 9, 14, 10),
              const Color.fromARGB(255, 118, 113, 167),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color.fromARGB(255, 10, 223, 223)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(baslik, style: TextStyle(color: yaziRengi)),
            Icon(Icons.arrow_drop_down, color: yaziRengi),
          ],
        ),
      ),
    );
  }
}

class FilmListesiSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Film Listesi')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BiletSecimiSayfasi()),
            );
          },
          child: Text('Bilet Seçimine Git'),
        ),
      ),
    );
  }
}

class BiletSecimiSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bilet Seçimi')),
      body: Center(child: Text('Bilet Seçimi Sayfası')),
    );
  }
}
