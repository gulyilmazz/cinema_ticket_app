// Arama sonucu bulunamadı widget'ı
import 'package:flutter/material.dart';
import 'package:cinemaa/core/theme/theme.dart';

class CinemaHallNoSearchResults extends StatelessWidget {
  const CinemaHallNoSearchResults({super.key});

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
                Icons.search_off,
                size: 70,
                color: Appcolor.buttonColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Aradığınız kriterlere uygun\nsinema salonu bulunamadı',
              style: TextStyle(
                fontSize: 16,
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
