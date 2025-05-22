import 'package:cinemaa/core/theme/theme.dart';
import 'package:flutter/material.dart';

class UsarnameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const UsarnameInput({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(color: Appcolor.white),
      decoration: InputDecoration(
        labelText: 'Kullanıcı Adı',
        labelStyle: TextStyle(
          color: Appcolor.white.withOpacity(0.7),
          fontSize: 16,
        ),
        hintText: 'Kullanıcı adınızı girin',
        hintStyle: TextStyle(
          color: Appcolor.white.withOpacity(0.5),
          fontSize: 14,
        ),
        filled: true,
        fillColor: Appcolor.grey.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Appcolor.grey, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Appcolor.buttonColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(
          Icons.person_outline,
          color: Appcolor.white.withOpacity(0.7),
          size: 22,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
