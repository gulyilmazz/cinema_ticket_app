// import 'package:cinemaa/models/movies_response.dart';
// import 'package:cinemaa/widgets/favori/favori_film_kart.dart';
// import 'package:cinemaa/widgets/favori/kayd%C4%B1rmali_film_kart.dart';
// import 'package:flutter/material.dart';
// import 'package:dots_indicator/dots_indicator.dart';

// // Film modeli (örnek veri)

// // Favori filmleri döndüren fonksiyon

// class FavScreen extends StatefulWidget {
//   const FavScreen({super.key});

//   @override
//   _FavScreenState createState() => _FavScreenState();
// }

// class _FavScreenState extends State<FavScreen> {
//   int _currentPage = 0;
//   final PageController _pageController = PageController();
//   List<Film> favoriFilmler = [];

//   @override
//   void initState() {
//     super.initState();
//     // Sadece favori filmleri al
//     favoriFilmler = Film.getFavorites();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color.fromARGB(255, 152, 147, 196),
//             const Color.fromARGB(255, 211, 208, 218),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
//             child: Text(
//               'Favori Filmlerim',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ),

//           // Favori filmin olmadığı durumu kontrol et
//           favoriFilmler.isEmpty
//               ? Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.favorite_border, size: 80, color: Colors.grey),
//                       SizedBox(height: 16),
//                       Text(
//                         'Henüz favori film eklemediniz',
//                         style: TextStyle(fontSize: 18, color: Colors.grey[700]),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Filmleri favorilere ekleyerek takip edebilirsiniz',
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//               : Expanded(
//                 child: Column(
//                   children: [
//                     // Kaydırmalı üst kısım
//                     SizedBox(
//                       height: 200,
//                       width: double.infinity,
//                       child: PageView.builder(
//                         controller: _pageController,
//                         itemCount: favoriFilmler.length,
//                         itemBuilder: (context, index) {
//                           return KaydirmaliFilmKarti(
//                             film: favoriFilmler[index],
//                           );
//                         },
//                         onPageChanged: (int page) {
//                           setState(() {
//                             _currentPage = page;
//                           });
//                         },
//                       ),
//                     ),

//                     // Nokta göstergesi
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: DotsIndicator(
//                         dotsCount: favoriFilmler.length,
//                         position: _currentPage,
//                         decorator: DotsDecorator(
//                           color: Color.fromARGB(255, 111, 145, 148),
//                           activeColor: Color.fromARGB(255, 10, 222, 230),
//                           size: const Size.square(8.0),
//                           activeSize: const Size(16.0, 8.0),
//                           activeShape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         onTap: (position) {
//                           _pageController.animateToPage(
//                             position,
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           );
//                         },
//                       ),
//                     ),

//                     SizedBox(height: 8),

//                     // Favori filmler grid listesi
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GridView.builder(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 childAspectRatio: 0.7,
//                                 crossAxisSpacing: 10,
//                                 mainAxisSpacing: 10,
//                               ),
//                           itemCount: favoriFilmler.length,
//                           itemBuilder: (context, index) {
//                             return FavoriFilmKarti(
//                               film: favoriFilmler[index],
//                               onFavoriteToggle: () {
//                                 setState(() {
//                                   favoriFilmler[index].isFavorite =
//                                       !favoriFilmler[index].isFavorite;
//                                   // Favori listesini güncelle
//                                   if (!favoriFilmler[index].isFavorite) {
//                                     favoriFilmler.removeAt(index);
//                                     // Eğer aktif olan sayfa kaldırıldıysa ve bu son sayfaysa
//                                     if (_currentPage >= favoriFilmler.length) {
//                                       _currentPage =
//                                           favoriFilmler.isEmpty
//                                               ? 0
//                                               : favoriFilmler.length - 1;
//                                       if (_pageController.hasClients) {
//                                         _pageController.jumpToPage(
//                                           _currentPage,
//                                         );
//                                       }
//                                     }
//                                   }
//                                 });
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//         ],
//       ),
//     );
//   }
// }
