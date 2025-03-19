import 'package:flutter/material.dart';
import 'register_screen.dart'; // Kayıt ekranını içe aktarır.
import '../main/home_film_listesi.dart'; // Ana sayfa (film listesi) ekranını içe aktarır.
import '../../utils/renkler.dart'; // Renkleri tanımlayan dosyayı içe aktarır.

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Kullanıcıdan e-posta ve şifre almak için controller'lar
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Şifrenin görünürlüğünü kontrol eden değişken
  bool _passwordVisible = false;

  // Klavyeyi kontrol etmek için odak düğümleri
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // Widget yok edildiğinde odakları temizleme işlemi
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Kullanıcı ekrana dokunduğunda klavyeyi kapatır
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, // Klavyenin içeriği kaydırmasını sağlar.
        extendBodyBehindAppBar:
            true, // İçeriğin üst çubuğun arkasına geçmesini sağlar.
        extendBody: true, // İçeriği ekranın tamamına yayar.
        backgroundColor:
            Renkler
                .arkaPlanRengi, // Arka plan rengi (renkler.dart'tan geliyor).
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
                  minHeight:
                      MediaQuery.of(
                        context,
                      ).size.height, // Ekran yüksekliği kadar genişlet.
                ),
                child: Container(
                  // Arka plan tasarımı: Kenarlık ve renk geçişi (gradient)
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
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
                        //  GIF Animasyonu (Video icon vb.)
                        Image.asset(
                          'lib/assets/images/video.gif', // GIF dosyanın yolu
                          height: 80, // GIF'in yüksekliği
                        ),
                        SizedBox(height: 40), // Boşluk bırak
                        // Uygulama adı
                        Text(
                          'SAHNE',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 247, 247, 247),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Açıklama yazısı
                        Text(
                          'Film Dünyasına Giriş Yapın',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 30),

                        //  Kullanıcı Adı (Username) Giriş Alanı
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
                        SizedBox(height: 20),

                        //  Şifre Giriş Alanı
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
                        SizedBox(height: 30),

                        //  Giriş Yap Butonu
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
                        SizedBox(height: 20),

                        //Kayıt ol butonu
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
