//Boş liste görünümü widget'ı
import 'package:flutter/material.dart';
import 'package:cinemaa/core/theme/theme.dart';

class CinemaHallEmptyView extends StatelessWidget {
  const CinemaHallEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appcolor.darkGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.movie_filter_outlined,
                size: 80,
                color: Appcolor.buttonColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Bu sinemada henüz salon bulunamadı',
              style: TextStyle(
                fontSize: 18,
                color: Appcolor.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
