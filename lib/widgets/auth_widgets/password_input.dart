import 'package:cinemaa/core/theme/theme.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const PasswordInput({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: !_passwordVisible,
      style: TextStyle(color: Appcolor.white),
      decoration: InputDecoration(
        labelText: 'Şifre',
        labelStyle: TextStyle(
          color: Appcolor.white.withValues(alpha: 0.7),
          fontSize: 16,
        ),
        hintText: 'Şifrenizi girin',
        hintStyle: TextStyle(
          color: Appcolor.white.withValues(alpha: 0.5),
          fontSize: 14,
        ),
        filled: true,
        fillColor: Appcolor.grey.withValues(alpha: 0.3),
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
          Icons.lock_outline,
          color: Appcolor.white.withValues(alpha: 0.7),
          size: 22,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Appcolor.white.withValues(alpha: 0.7),
            size: 22,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          splashRadius: 20,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
