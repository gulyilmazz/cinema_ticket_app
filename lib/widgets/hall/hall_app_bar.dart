import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class HallAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String cityName;

  const HallAppBar({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Appcolor.darkGrey,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Appcolor.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Sinema Salonları',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Appcolor.white,
          fontSize: 18,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Appcolor.buttonColor,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                cityName,
                style: const TextStyle(
                  color: Appcolor.buttonColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
