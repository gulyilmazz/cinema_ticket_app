// Favori film kartı widget'ı
import 'package:cinemaa/models/film_model.dart';
import 'package:flutter/material.dart';

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
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 14, 12, 9),
                        size: 16,
                      ),
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
