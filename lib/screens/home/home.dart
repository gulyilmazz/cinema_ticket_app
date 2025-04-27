import 'package:cinemaa/screens/bottoms/filtreleme_secenekleri_sayfas%C4%B1.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/screens/bottoms/fav_screen.dart';
import 'package:cinemaa/screens/bottoms/bilet_screen.dart';
import 'package:cinemaa/widgets/buttons/left_drawer.dart';

// Film modeli - tüm uygulama boyunca kullanılabilir
class Film {
  final String id;
  final String baslik;
  final String resimUrl;
  final String aciklama;
  final double puan;
  final String yonetmen;
  final List<String> oyuncular;
  final String vizyon;
  final String sure;
  final String kategori;
  bool isFavorite;

  Film({
    required this.id,
    required this.baslik,
    required this.resimUrl,
    required this.aciklama,
    required this.puan,
    required this.yonetmen,
    required this.oyuncular,
    required this.vizyon,
    required this.sure,
    required this.kategori,
    this.isFavorite = false,
  });

  // Örnek film verileri
  static List<Film> filmler = [
    Film(
      id: '1',
      baslik: 'The Brutalist',
      resimUrl: 'assets/film1.jpg',
      aciklama:
          'Savaş sonrası Amerika\'da yeni bir başlangıç arayan Macar göçmen bir mimar, vizyoner bir müşteri tarafından fark edildiğinde hayatı değişir. Ancak geçmişi ve kimliği ile yüzleşmek zorunda kalır.',
      puan: 8.5,
      yonetmen: 'Brady Corbet',
      oyuncular: ['Adrian Brody', 'Felicity Jones', 'Guy Pearce'],
      vizyon: '31 Ocak 2025',
      sure: '145 dk',
      kategori: 'Drama',
    ),
    Film(
      id: '2',
      baslik: 'Maria',
      resimUrl: 'assets/film2.jpg',
      aciklama:
          'Ünlü opera sanatçısı Maria Callas\'ın hayatının son günlerini anlatan etkileyici bir biyografi filmi. Sanat, tutku ve kişisel mücadeleler arasında geçen bir yaşam hikayesi.',
      puan: 7.9,
      yonetmen: 'Steven Knight',
      oyuncular: ['Angelina Jolie', 'Alba Rohrwacher', 'Valeria Golino'],
      vizyon: '15 Şubat 2025',
      sure: '120 dk',
      kategori: 'Biyografi',
      isFavorite: true,
    ),
    Film(
      id: '3',
      baslik: 'Aile Komedisi',
      resimUrl: 'assets/film3.jpg',
      aciklama:
          'Büyük bir aile toplantısında beklenmedik olaylar sonucu ortaya çıkan sırlar ve komik durumlar. Türk sinemasının sevilen oyuncuları bir araya geliyor.',
      puan: 6.8,
      yonetmen: 'Ali Taner Baltacı',
      oyuncular: ['Ata Demirer', 'Demet Akbağ', 'Yılmaz Erdoğan'],
      vizyon: '10 Mart 2025',
      sure: '105 dk',
      kategori: 'Komedi',
    ),
    Film(
      id: '4',
      baslik: 'Son Bir Nefes',
      resimUrl: 'assets/film4.jpg',
      aciklama:
          'Uluslararası bir uzay istasyonunda geçen, nefes kesen bir bilim kurgu gerilimi. Oksijen tükenmekte ve mürettebat arasındaki güven sarsılmaktadır.',
      puan: 9.0,
      yonetmen: 'David Chang',
      oyuncular: ['Mark Lee', 'John Cho', 'Michelle Yeoh'],
      vizyon: '5 Nisan 2025',
      sure: '116 dk',
      kategori: 'Bilim Kurgu',
    ),
  ];

  // Kategoriye göre filmleri döndüren fonksiyon
  static List<Film> getFilmsByCategory(String category) {
    if (category == 'Tümü') {
      return filmler;
    }
    return filmler.where((film) => film.kategori == category).toList();
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Sayfaları düzgün sırayla listeliyoruz
  final List<Widget> _pages = [
    AnaSayfaIcerigi(),
    FavScreen(),
    FiltrelemeSecenekleriSayfasi(),
    BiletlerSayfasi(),
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
            label: 'Filtrele',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Biletler',
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

class AnaSayfaIcerigi extends StatefulWidget {
  @override
  _AnaSayfaIcerigiState createState() => _AnaSayfaIcerigiState();
}

class _AnaSayfaIcerigiState extends State<AnaSayfaIcerigi>
    with SingleTickerProviderStateMixin {
  bool _isSearchVisible = false;
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  final List<String> _kategoriler = [
    'Tümü',
    'Drama',
    'Komedi',
    'Aksiyon',
    'Bilim Kurgu',
    'Biyografi',
    'Korku',
    'Romantik',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _kategoriler.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Arama kutusu
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color.fromARGB(255, 10, 222, 230),
                  width: 1,
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 9, 14, 10),
                    const Color.fromARGB(255, 118, 113, 167),
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: const Color.fromARGB(255, 10, 222, 230),
                  ),
                  SizedBox(width: 8),
                  _isSearchVisible
                      ? Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Film Ara...',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : Text(
                        'Film Ara',
                        style: TextStyle(color: Colors.white70),
                      ),
                ],
              ),
            ),
          ),
        ),

        // Kategori sekmeleri
        Container(
          height: 40,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 10, 222, 230).withOpacity(0.3),
            ),
            labelColor: const Color.fromARGB(255, 10, 222, 230),
            unselectedLabelColor: Colors.black54,
            tabs: _kategoriler.map((kategori) => Tab(text: kategori)).toList(),
            onTap: (index) {
              // Kategori değişikliğinde yapılacak işlemler
              setState(() {});
            },
          ),
        ),

        // Film kategorileri
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:
                _kategoriler.map((kategori) {
                  return FilmKategorileri(kategori: kategori);
                }).toList(),
          ),
        ),
      ],
    );
  }
}

class FilmKategorileri extends StatelessWidget {
  final String kategori;

  FilmKategorileri({required this.kategori});

  @override
  Widget build(BuildContext context) {
    List<Film> filmler = Film.getFilmsByCategory(kategori);

    return ListView(
      children: [
        _kategoriBolumu(context, 'Vizyondaki Filmler', filmler),
        _kategoriBolumu(context, 'Önerilen Filmler', filmler),
        _kategoriBolumu(context, 'Yakında', filmler),
      ],
    );
  }

  Widget _kategoriBolumu(
    BuildContext context,
    String baslik,
    List<Film> filmler,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            baslik,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filmler.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Film detay sayfasına yönlendirme
                    _navigateToFilmDetail(context, filmler[index]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color.fromARGB(255, 10, 222, 230),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(filmler[index].resimUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        filmler[index].baslik,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Film detay sayfasına yönlendirme fonksiyonu
  void _navigateToFilmDetail(BuildContext context, Film film) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilmDetaySayfasi(film: film)),
    );
  }
}

// Film detay sayfası
class FilmDetaySayfasi extends StatefulWidget {
  final Film film;

  const FilmDetaySayfasi({Key? key, required this.film}) : super(key: key);

  @override
  _FilmDetaySayfasiState createState() => _FilmDetaySayfasiState();
}

class _FilmDetaySayfasiState extends State<FilmDetaySayfasi> {
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
        child: CustomScrollView(
          slivers: [
            // Üstteki resim ve app bar
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(widget.film.resimUrl, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.film.baslik,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      widget.film.puan.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      widget.film.kategori,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Favori butonu
                          IconButton(
                            icon: Icon(
                              widget.film.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.film.isFavorite =
                                    !widget.film.isFavorite;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    widget.film.isFavorite
                                        ? '${widget.film.baslik} favorilere eklendi'
                                        : '${widget.film.baslik} favorilerden çıkarıldı',
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 9, 14, 10),
              iconTheme: IconThemeData(
                color: const Color.fromARGB(255, 10, 223, 230),
              ),
            ),

            // İçerik
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bilgiler
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Yönetmen', widget.film.yonetmen),
                          _buildInfoRow(
                            'Oyuncular',
                            widget.film.oyuncular.join(', '),
                          ),
                          _buildInfoRow('Vizyon Tarihi', widget.film.vizyon),
                          _buildInfoRow('Süre', widget.film.sure),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Açıklama
                    Text(
                      'Film Açıklaması',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.film.aciklama,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),

                    SizedBox(height: 24),

                    // Bilet al butonu
                    InkWell(
                      onTap: () {
                        // Bilet sayfasına yönlendirme
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BiletAlSayfasi(film: widget.film),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 9, 14, 10),
                              const Color.fromARGB(255, 118, 113, 167),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 10, 222, 230),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Bilet Al',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

// Bilet alma sayfası
class BiletAlSayfasi extends StatelessWidget {
  final Film film;

  const BiletAlSayfasi({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bilet Al: ${film.baslik}',
          style: TextStyle(
            color: const Color.fromARGB(255, 10, 223, 230),
            fontSize: 18,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 9, 14, 10),
                const Color.fromARGB(255, 118, 113, 167),
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 10, 223, 230),
        ),
      ),
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
        child: Center(
          child: Text(
            'Bilet alma sayfası yapım aşamasında',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
