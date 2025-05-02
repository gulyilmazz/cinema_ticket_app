import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/screens/cities/cities.dart';
import 'package:cinemaa/services/auth/auth_service.dart';
import 'package:cinemaa/widgets/auth_widgets/password_input.dart';
import 'package:cinemaa/widgets/auth_widgets/register_button.dart';
import 'package:cinemaa/widgets/auth_widgets/usarname_input.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../../utils/renkler.dart';

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
          MaterialPageRoute(
            builder: (context) => CitiesScreen(),
          ), // Giriş sonrası gidilecek ekran
        );
      } else {
        // Giriş başarısızsa hatayı göster
        throw Exception(response.message);
      }
    } catch (e) {
      // Hata durumunda kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Giriş başarısız: ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
                    borderRadius: BorderRadius.circular(20),
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
                          'Film Dünyasına Giriş Yapın',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 30),

                        UsarnameInput(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                        ),
                        SizedBox(height: 20),

                        PasswordInput(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
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
                          ),
                          onPressed: () {
                            login(context); // Giriş yapma işlemi
                          },
                          child:
                              isLoading
                                  ? CircularProgressIndicator()
                                  : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Giriş Yap",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                        ),
                        // LoginButton(
                        //   onPressed: () {
                        //     login(context); // Giriş yapma işlemi
                        //   },
                        // ),
                        SizedBox(height: 20),
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

                        /*//  Kullanıcı Adı (Username) Giriş Alanı
                        TextField(
                          controller:
                              _emailController, // Kullanıcı adını kontrol eder.
                          focusNode: _emailFocusNode,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 3, 12, 19),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ), // Kullanıcı ikonu
                          ),
                        ),
                        SizedBox(height: 20),*/
                        /*//  Şifre Giriş Alanı
                        TextField(
                          controller:
                              _passwordController, // Şifreyi kontrol eder.
                          focusNode: _passwordFocusNode,
                          obscureText:
                              !_passwordVisible, // Şifreyi gizler veya gösterir.
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 203, 217, 229),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ), // Kilit ikonu
                            // Şifreyi göster/gizle butonu
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 30),*/

                        /*//  Giriş Yap Butonu
                        ElevatedButton(
                          onPressed: () {
                            // Kullanıcı giriş yaptıktan sonra film listesi ekranına gider.
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilmTry(),
                              ),
                            );
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
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            child: Text(
                              'Giriş >',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),*/

                        /*//Kayıt ol butonu
                        TextButton(
                          onPressed: () {
                            // Kullanıcı, kayıt ekranına yönlendirilir.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Hesabın yok mu? Kayıt ol",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 199, 195, 195),
                            ),
                          ),
                        ),*/
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
