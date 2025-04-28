import 'package:cinemaa/widgets/home/movie_category.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
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
                  return MovieCategory(kategori: kategori);
                }).toList(),
          ),
        ),
      ],
    );
  }
}
