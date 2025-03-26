//bu widget yatay kaydırma seklinde gösterir
// film_kaydirma.dart (movie_widgets klasöründe)
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../models/film_model.dart';
import 'kaydirmali_film_karti.dart';

class FilmKaydirma extends StatefulWidget {
  @override
  _FilmKaydirmaState createState() => _FilmKaydirmaState();
}

class _FilmKaydirmaState extends State<FilmKaydirma> {
  int _currentPage = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: 385,
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: Film.filmler.length,
            itemBuilder: (context, index) {
              return KaydirmaliFilmKarti(film: Film.filmler[index]);
            },
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
        ),
        DotsIndicator(
          dotsCount: Film.filmler.length,
          position: _currentPage.toInt(),
          decorator: DotsDecorator(
            color: Colors.grey,
            activeColor: const Color.fromARGB(255, 31, 177, 187),
          ),
          onTap: (position) {
            _pageController.animateToPage(
              position,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ],
    );
  }
}
