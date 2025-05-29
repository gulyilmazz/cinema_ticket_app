import 'package:cinemaa/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CitiesLoadingState extends StatelessWidget {
  const CitiesLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appcolor.darkGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Appcolor.buttonColor,
                  ),
                  strokeWidth: 4,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Şehirler yükleniyor...',
              style: TextStyle(
                color: Appcolor.white.withValues(alpha: 0.8),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
