import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/screens/main_screen.dart';
import 'package:cinemaa/services/auth/auth_service.dart';
import 'package:cinemaa/widgets/auth_widgets/password_input.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool isLoading = false;
  bool _confirmPasswordVisible = false;

  Future<void> register(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _authService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
      );

      if (response.success!) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kayıt başarısız: ${e.toString()}"),
          backgroundColor: Appcolor.grey,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleRegister() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Appcolor.white),
              SizedBox(width: 8),
              Text('Şifreler eşleşmiyor!'),
            ],
          ),
          backgroundColor: Colors.red.shade600,
        ),
      );
      return;
    }
    register(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
                        const SizedBox(height: 32),

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
                          'Film Dünyasına Kayıt Olun',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Appcolor.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Name Input
                        _buildNameInput(),
                        const SizedBox(height: 16),

                        // Email Input
                        _buildEmailInput(),
                        const SizedBox(height: 16),

                        // Password Input
                        PasswordInput(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password Input
                        _buildConfirmPasswordInput(),
                        const SizedBox(height: 32),

                        // Register Button
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
                            onPressed: isLoading ? null : _handleRegister,
                            child:
                                isLoading
                                    ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Appcolor.appBackgroundColor,
                                            ),
                                      ),
                                    )
                                    : Text(
                                      "Kayıt Ol",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Appcolor.appBackgroundColor,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Back to Login Button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            "Zaten hesabın var mı? Giriş yap",
                            style: TextStyle(
                              color: Appcolor.buttonColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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

  Widget _buildNameInput() {
    return TextField(
      controller: _nameController,
      focusNode: _nameFocusNode,
      style: TextStyle(color: Appcolor.white),
      decoration: InputDecoration(
        labelText: 'Ad Soyad',
        labelStyle: TextStyle(
          color: Appcolor.white.withOpacity(0.7),
          fontSize: 16,
        ),
        hintText: 'Adınızı ve soyadınızı girin',
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
        prefixIcon: Icon(
          Icons.person_outline,
          color: Appcolor.white.withOpacity(0.7),
          size: 22,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildEmailInput() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Appcolor.white),
      decoration: InputDecoration(
        labelText: 'E-posta',
        labelStyle: TextStyle(
          color: Appcolor.white.withOpacity(0.7),
          fontSize: 16,
        ),
        hintText: 'ornek@email.com',
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
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Appcolor.white.withOpacity(0.7),
          size: 22,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildConfirmPasswordInput() {
    return TextField(
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocusNode,
      obscureText: !_confirmPasswordVisible,
      style: TextStyle(color: Appcolor.white),
      decoration: InputDecoration(
        labelText: 'Şifre Tekrar',
        labelStyle: TextStyle(
          color: Appcolor.white.withOpacity(0.7),
          fontSize: 16,
        ),
        hintText: 'Şifrenizi tekrar girin',
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
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Appcolor.white.withOpacity(0.7),
          size: 22,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Appcolor.white.withOpacity(0.7),
            size: 22,
          ),
          onPressed: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          },
          splashRadius: 20,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
