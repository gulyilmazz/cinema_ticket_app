import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/models/cities_response.dart';
import 'package:flutter/material.dart';

class CityListItem extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const CityListItem({super.key, required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cityName = city.name ?? 'İsimsiz Şehir';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Appcolor.grey.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: Appcolor.buttonColor.withValues(alpha: 0.1),
          highlightColor: Appcolor.buttonColor.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Appcolor.buttonColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Appcolor.buttonColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    cityName,
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Appcolor.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Appcolor.buttonColor,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
