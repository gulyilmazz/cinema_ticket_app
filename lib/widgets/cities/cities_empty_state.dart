import 'package:cinemaa/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CitiesEmptyState extends StatelessWidget {
  const CitiesEmptyState({super.key});

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
                  color: Appcolor.buttonColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.location_city_rounded,
                  size: 60,
                  color: Appcolor.buttonColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Gösterilecek şehir bulunamadı',
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Lütfen daha sonra tekrar deneyin',
                style: TextStyle(
                  color: Appcolor.white.withValues(alpha: 0.7),
                  fontSize: 14,
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
