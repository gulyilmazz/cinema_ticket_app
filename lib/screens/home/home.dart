import 'package:cinemaa/widgets/home/movie_category.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
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

  final LinearGradient appGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color.fromARGB(255, 9, 14, 10),
      const Color.fromARGB(255, 85, 81, 124),
    ],
  );

  final Color turkuazRenk = const Color.fromARGB(255, 10, 222, 230);

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
    return Container(
      decoration: BoxDecoration(gradient: appGradient),
      child: Column(
        children: [
          // Arama alanı
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSearchVisible = !_isSearchVisible;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: turkuazRenk, width: 1),
                  gradient: appGradient,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(Icons.search, color: turkuazRenk),
                    SizedBox(width: 3),
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
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(gradient: appGradient),
            height: 55,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(),
              labelColor: turkuazRenk,
              unselectedLabelColor: Colors.white70,
              tabs:
                  _kategoriler.map((kategori) => Tab(text: kategori)).toList(),
              onTap: (index) {
                setState(() {});
              },
            ),
          ),

          SizedBox(height: 10),

          // Film kategorileri
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  _kategoriler.map((kategori) {
                    return MovieCategoryWrapper(
                      // ignore: sort_child_properties_last
                      child: MovieCategory(kategori: kategori),
                      turkuazRenk: turkuazRenk,
                      appGradient: appGradient,
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Wrapper sınıfı - Film kategorilerini turkuaz çerçeve ve gradient arka plan ile sarar
class MovieCategoryWrapper extends StatelessWidget {
  final Widget child;
  final Color turkuazRenk;
  final LinearGradient appGradient;

  const MovieCategoryWrapper({
    super.key,
    required this.child,
    required this.turkuazRenk,
    required this.appGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(gradient: appGradient),
      child: child,
    );
  }
}
