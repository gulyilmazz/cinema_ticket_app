// ignore_for_file: use_build_context_synchronously

import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/screens/cities/cities.dart';
import 'package:cinemaa/services/auth/auth_service.dart';
import 'package:cinemaa/widgets/auth_widgets/password_input.dart';
import 'package:cinemaa/widgets/auth_widgets/register_button.dart';
import 'package:cinemaa/widgets/auth_widgets/usarname_input.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool isLoading = false;

  Future<void> login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.success!) {
        await AuthStorage.saveToken(response.data!.token!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CitiesScreen()),
        );
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Giriş başarısız: ${e.toString()}"),
          backgroundColor: Appcolor.grey,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Appcolor.appBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      32,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Appcolor.darkGrey,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Appcolor.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Logo/Icon
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Appcolor.buttonColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/images/video.gif',
                            height: 60,
                            color: Appcolor.buttonColor,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // App Title
                        Text(
                          'SAHNE',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.white,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle
                        Text(
                          'Film Dünyasına Giriş Yapın',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Appcolor.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Username Input
                        UsarnameInput(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                        ),
                        const SizedBox(height: 20),

                        // Password Input
                        PasswordInput(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                        ),
                        const SizedBox(height: 40),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.buttonColor,
                              foregroundColor: Appcolor.appBackgroundColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: isLoading ? null : () => login(context),
                            child:
                                isLoading
                                    ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Appcolor.buttonColor,
                                            ),
                                      ),
                                    )
                                    : Text(
                                      "Giriş Yap",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Appcolor.appBackgroundColor,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Register Button
                        RegisterButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
