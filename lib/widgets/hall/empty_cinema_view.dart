import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class EmptyCinemaView extends StatelessWidget {
  const EmptyCinemaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_filter_outlined,
            size: 80,
            color: Appcolor.white.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'Bu şehirde henüz sinema salonu bulunamadı',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Appcolor.white.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
