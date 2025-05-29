import 'package:cinemaa/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CitiesAppBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onBackPressed;

  const CitiesAppBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBackPressed,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Appcolor.grey,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Appcolor.buttonColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Appcolor.buttonColor,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Şehir Seçimi',
                  style: TextStyle(
                    color: Appcolor.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Appcolor.buttonColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.location_city,
                  color: Appcolor.buttonColor,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Appcolor.grey.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Appcolor.buttonColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              style: TextStyle(color: Appcolor.white),
              decoration: InputDecoration(
                hintText: 'Şehir ara...',
                hintStyle: TextStyle(
                  color: Appcolor.white.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Appcolor.buttonColor,
                  size: 22,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(
                            Icons.clear_rounded,
                            color: Appcolor.white.withValues(alpha: 0.7),
                          ),
                          onPressed: () {
                            searchController.clear();
                            onSearchChanged('');
                          },
                        )
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
