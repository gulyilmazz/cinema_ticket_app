import 'package:cinemaa/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CitiesNoSearchResults extends StatelessWidget {
  final String searchQuery;

  const CitiesNoSearchResults({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Appcolor.darkGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Appcolor.grey.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.search_off_rounded,
                  size: 60,
                  color: Appcolor.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '"$searchQuery" için sonuç bulunamadı',
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
