import 'package:cinemaa/screens/alt_buton/bilet_screen.dart';
import 'package:cinemaa/screens/alt_buton/fav_screen.dart';
import 'package:cinemaa/screens/alt_buton/filtreleme_secenekleri_sayfası.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:cinemaa/models/film_model.dart';
import 'package:cinemaa/widgets/home_widgets/film_karti.dart';
import 'package:cinemaa/widgets/home_widgets/kaydirmali_film_karti.dart';

class FilmTry extends StatefulWidget {
  @override
  _FilmTryState createState() => _FilmTryState();
}

class _FilmTryState extends State<FilmTry> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  PageController _pageController = PageController();

  final List<Widget> _pages = [
    FavorilerSayfasi(),
    FiltrelemeSecenekleriSayfasi(),
    BiletlerSayfasi(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Ana sayfa tasarımı
    return Scaffold(
      appBar: AppBar(
        title: Text('Vizyondaki Filmler'),
        backgroundColor: const Color.fromARGB(255, 31, 177, 187),
      ),
      //Drawer içindeki menü
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 31, 177, 187),
              ),
              child: Text(
                'Menü',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Ana Sayfa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ayarlar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      //Ana sayfa icerigi
      body: IndexedStack(
        //alt buton kaybolması için kullanılan widget

        /* acıklma: IndexedStack, birden fazla widget'ı üst üste yerleştirir ve
        _selectedIndex'e göre sadece birini görüntüler.
        Bu, alt navigasyon çubuğundaki sayfa geçişlerini yönetir.*/
        index: _selectedIndex,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                //Kaydırılan filmlerin bulunduğu alan
                height: 200,
                width: double.infinity,
                child: PageView.builder(
                  //PageView, kaydırılabilir bir widget oluşturur
                  physics:
                      NeverScrollableScrollPhysics(), //Kaydırma özelliğini kapatır
                  controller: _pageController,
                  itemCount:
                      Film
                          .filmler
                          .length, //Film sayısı kadar kaydırılabilir alan oluşturur
                  itemBuilder: (context, index) {
                    //Kaydırılan filmler
                    return KaydirmaliFilmKarti(film: Film.filmler[index]);
                  },
                  onPageChanged: (int page) {
                    setState(() {
                      //Kaydırılan filmler arasında geçiş yaparken sayfa numarasını günceller

                      _currentPage =
                          page; //_currentPage, sayfa numarasını tutar
                    });
                  },
                ),
              ),

              //Kaydırılan filmlerin altında bulunan noktalar
              DotsIndicator(
                dotsCount:
                    Film.filmler.length, //Film sayısı kadar nokta oluşturur
                position: _currentPage.toInt(), //Noktaların konumunu günceller
                decorator: DotsDecorator(
                  //Noktaların tasarımını belirler
                  color: const Color.fromARGB(255, 111, 145, 148),
                  activeColor: const Color.fromARGB(255, 31, 177, 187),
                ),
                onTap: (position) {
                  _pageController.animateToPage(
                    //Noktalara tıklandığında sayfayı değiştirir
                    position,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease, //Sayfa geçişini yumuşatır
                  );
                },
              ),
              Expanded(
                //Film listesini ızgara şeklinde gösteren GridView.builder için boş alanı doldurur.
                child: Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //Izgara görünümünü belirler
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: Film.filmler.length,
                    itemBuilder: (context, index) {
                      return FilmKarti(film: Film.filmler[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
          ..._pages,
        ],
      ),
      //Alt navigasyon çubuğu
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
