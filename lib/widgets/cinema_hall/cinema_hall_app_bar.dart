// AppBar widget'ı
import 'package:flutter/material.dart';
import 'package:cinemaa/core/theme/theme.dart';

class CinemaHallAppBar extends StatelessWidget {
  final VoidCallback onRefresh;

  const CinemaHallAppBar({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Appcolor.appBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Appcolor.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Sinema Salonları',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Appcolor.appBackgroundColor, Appcolor.darkGrey],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Appcolor.buttonColor),
          onPressed: onRefresh,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
