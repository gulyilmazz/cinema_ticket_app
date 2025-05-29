//Arama çubuğu widget'ı
import 'package:flutter/material.dart';
import 'package:cinemaa/core/theme/theme.dart';

class CinemaHallSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClear;

  const CinemaHallSearchBar({
    super.key,
    required this.controller,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Appcolor.darkGrey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Appcolor.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Salon ara...',
            hintStyle: TextStyle(color: Appcolor.white.withValues(alpha: 0.6)),
            prefixIcon: const Icon(
              Icons.search,
              color: Appcolor.buttonColor,
              size: 24,
            ),
            suffixIcon:
                controller.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Appcolor.buttonColor,
                      ),
                      onPressed: onClear,
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
          ),
        ),
      ),
    );
  }
}
