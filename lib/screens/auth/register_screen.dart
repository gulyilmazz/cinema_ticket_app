import 'package:cinemaa/screens/main_screen.dart';
import 'package:cinemaa/services/auth/auth_service.dart';
import 'package:cinemaa/utils/renkler.dart';
import 'package:cinemaa/widgets/auth_widgets/password_input.dart';
import 'package:cinemaa/widgets/auth_widgets/usarname_input.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthService _authService = AuthService();

  bool isLoading = false;

  Future<void> register(BuildContext context) async {
    setState(() {
      isLoading =
          true; // Kayıt işlemi başlatıldığında yükleniyor durumunu ayarla
    });
    try {
      final response = await _authService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
      );

      if (response.success!) {
        // await AuthStorage.saveToken(response.data.token);
        // final userId = response.data.user.id;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      // _errorMessage = e.toString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Kayıt başarısız: ")));
    } finally {
      isLoading =
          false; // Kayıt işlemi başlatıldığında yükleniyor durumunu ayarla
      // setButtonPressed(false);
    }
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  // Kullanıcıdan şifre almak için kontrolcü
  final TextEditingController _passwordController = TextEditingController();
  // Kullanıcıdan şifre doğrulama bilgisi almak için kontrolcü
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus
            ?.unfocus(); // Klavye kapanır
      },
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, // Klavye açıldığında ekranın boyutunu küçültür
        extendBodyBehindAppBar: true, // Appbar'ın arka plana geçmesini sağlar
        extendBody: true,
        backgroundColor: Renkler.arkaPlanRengi,

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom:
                    MediaQuery.of(context).viewInsets.bottom +
                    MediaQuery.of(context).padding.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      // Arka plan rengi
                      colors: [
                        const Color.fromARGB(255, 8, 12, 9),
                        const Color.fromARGB(255, 90, 85, 134),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/video.gif', height: 80),
                        SizedBox(height: 40),

                        Text(
                          'SAHNE',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 247, 247, 247),
                          ),
                        ),
                        SizedBox(height: 10),

                        Text(
                          'Film Dünyasına Kayıt Olun',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 149, 223, 223),
                          ),
                        ),
                        SizedBox(height: 30),

                        UsarnameInput(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                        ),
                        UsarnameInput(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                        ),

                        PasswordInput(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                        ),
                        SizedBox(height: 20),

                        // Şifre Tekrar Giriş Alanı
                        TextField(
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Şifre Tekrar',
                            labelStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 149, 223, 223),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 149, 223, 223),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Kayıt Ol Butonu
                        ElevatedButton(
                          onPressed: () {
                            // Kayıt işlemi burada yapılacak
                            // Şifrelerin eşleşip eşleşmediği kontrol edilebilir
                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              register(context);
                            } else {
                              // Şifreler eşleşmiyorsa uyarı göster
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Şifreler eşleşmiyor!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              42,
                              43,
                              38,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            minimumSize: Size(double.infinity, 0),
                          ),
                          child:
                              isLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                    'Kayıt Ol',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                        ),
                        SizedBox(height: 20),

                        // Giriş Ekranına Dön Butonu
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Zaten hesabın var mı? Giriş yap",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 149, 223, 223),
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
}
