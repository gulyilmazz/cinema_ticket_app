import 'package:cinemaa/widgets/buttons/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:cinemaa/models/film_model.dart';
import 'package:cinemaa/widgets/movies_widgets/film_karti.dart';
import 'package:cinemaa/widgets/movies_widgets/kaydirmali_film_karti.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentPage = 0; // State tutulmadığı için burada tanımlıyoruz
    PageController pageController =
        PageController(); // State tutulmadığı için burada tanımlıyoruz

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vizyona Girecek Filmler'),
        backgroundColor: const Color.fromARGB(255, 221, 202, 30),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: Film.filmler.length,
              itemBuilder: (context, index) {
                return KaydirmaliFilmKarti(film: Film.filmler[index]);
              },
              onPageChanged: (int page) {
                // State tutulmadığı için setState kullanamıyoruz
                currentPage = page;
              },
            ),
          ),
          DotsIndicator(
            dotsCount: Film.filmler.length,
            position: currentPage.toInt(),
            decorator: const DotsDecorator(
              color: Color.fromARGB(255, 111, 145, 148),
              activeColor: Color.fromARGB(255, 126, 168, 11),
            ),
            onTap: (position) {
              pageController.animateToPage(
                position,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
