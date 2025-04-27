import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

// Film modeli (örnek veri)
class Film {
  final String baslik;
  final String resimUrl;
  final String aciklama;
  final double puan;
  bool isFavorite;

  Film({
    required this.baslik,
    required this.resimUrl,
    required this.aciklama,
    required this.puan,
    this.isFavorite = false,
  });

  // Örnek film verileri
  static List<Film> filmler = [
    Film(
      baslik: 'The Brutalist',
      resimUrl: 'assets/film1.jpg',
      aciklama: 'Film 1 Açıklaması',
      puan: 8.5,
      isFavorite: true,
    ),
    Film(
      baslik: 'Maria',
      resimUrl: 'assets/film2.jpg',
      aciklama: 'Film 2 Açıklaması',
      puan: 7.9,
      isFavorite: true,
    ),
    Film(
      baslik: 'Aile Komedisi',
      resimUrl: 'assets/film3.jpg',
      aciklama: 'Film 3 Açıklaması',
      puan: 6.8,
    ),
    Film(
      baslik: 'Son Bir Nefes',
      resimUrl: 'assets/film4.jpg',
      aciklama: 'Film 4 Açıklaması',
      puan: 9.0,
    ),
  ];

  // Favori filmleri döndüren fonksiyon
  static List<Film> getFavorites() {
    return filmler.where((film) => film.isFavorite).toList();
  }
}

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  List<Film> favoriFilmler = [];

  @override
  void initState() {
    super.initState();
    // Sadece favori filmleri al
    favoriFilmler = Film.getFavorites();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 152, 147, 196),
            const Color.fromARGB(255, 211, 208, 218),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
            child: Text(
              'Favori Filmlerim',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // Favori filmin olmadığı durumu kontrol et
          favoriFilmler.isEmpty
              ? Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Henüz favori film eklemediniz',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Filmleri favorilere ekleyerek takip edebilirsiniz',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              )
              : Expanded(
                child: Column(
                  children: [
                    // Kaydırmalı üst kısım
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: favoriFilmler.length,
                        itemBuilder: (context, index) {
                          return KaydirmaliFilmKarti(
                            film: favoriFilmler[index],
                          );
                        },
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                      ),
                    ),

                    // Nokta göstergesi
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DotsIndicator(
                        dotsCount: favoriFilmler.length,
                        position: _currentPage,
                        decorator: DotsDecorator(
                          color: Color.fromARGB(255, 111, 145, 148),
                          activeColor: Color.fromARGB(255, 10, 222, 230),
                          size: const Size.square(8.0),
                          activeSize: const Size(16.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onTap: (position) {
                          _pageController.animateToPage(
                            position,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 8),

                    // Favori filmler grid listesi
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: favoriFilmler.length,
                          itemBuilder: (context, index) {
                            return FavoriFilmKarti(
                              film: favoriFilmler[index],
                              onFavoriteToggle: () {
                                setState(() {
                                  favoriFilmler[index].isFavorite =
                                      !favoriFilmler[index].isFavorite;
                                  // Favori listesini güncelle
                                  if (!favoriFilmler[index].isFavorite) {
                                    favoriFilmler.removeAt(index);
                                    // Eğer aktif olan sayfa kaldırıldıysa ve bu son sayfaysa
                                    if (_currentPage >= favoriFilmler.length) {
                                      _currentPage =
                                          favoriFilmler.isEmpty
                                              ? 0
                                              : favoriFilmler.length - 1;
                                      if (_pageController.hasClients) {
                                        _pageController.jumpToPage(
                                          _currentPage,
                                        );
                                      }
                                    }
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

// Kaydırmalı film kartı widget'ı
class KaydirmaliFilmKarti extends StatelessWidget {
  final Film film;

  const KaydirmaliFilmKarti({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 8),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(film.resimUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      film.baslik,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(
                          film.puan.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Favori film kartı widget'ı
class FavoriFilmKarti extends StatelessWidget {
  final Film film;
  final VoidCallback onFavoriteToggle;

  const FavoriFilmKarti({
    Key? key,
    required this.film,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Film resmi ve favori butonu
          Expanded(
            flex: 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    film.resimUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Favori butonu
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        film.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 20,
                      ),
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Film bilgileri
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    film.baslik,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 2),
                      Text(
                        film.puan.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
