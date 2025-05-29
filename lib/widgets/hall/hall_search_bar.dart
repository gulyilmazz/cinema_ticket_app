import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class HallSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const HallSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Appcolor.darkGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 16, color: Appcolor.white),
          decoration: InputDecoration(
            hintText: 'Sinema salonu ara...',
            hintStyle: TextStyle(color: Appcolor.white.withValues(alpha: 0.6)),
            prefixIcon: const Icon(Icons.search, color: Appcolor.buttonColor),
            suffixIcon:
                controller.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear, color: Appcolor.white),
                      onPressed: () {
                        controller.clear();
                        onChanged('');
                      },
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
