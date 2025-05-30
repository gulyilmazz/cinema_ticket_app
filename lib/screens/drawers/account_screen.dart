import 'package:flutter/material.dart';
// import 'app_colors.dart'; // Tema dosyanızı import edin

class Appcolor {
  static const appBackgroundColor = Color(0xFF1c1c27);
  static const grey = Color(0xFF373741);
  static const buttonColor = Color(0xFFffb43b);
  static const white = Colors.white;
  static const darkGrey = Color(0xFF252532);
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Hesabım',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Appcolor.buttonColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Appcolor.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profil Kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Appcolor.darkGrey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Appcolor.buttonColor, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundColor: Appcolor.grey,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Appcolor.buttonColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Gül Yılmaz',
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.buttonColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Premium Üye',
                      style: TextStyle(
                        color: Appcolor.buttonColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // İstatistikler
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Toplam Sipariş',
                    '47',
                    Icons.shopping_bag,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Puan', '2,850', Icons.star)),
              ],
            ),

            const SizedBox(height: 24),

            // Kişisel Bilgiler
            _buildSectionCard('Kişisel Bilgiler', [
              _buildInfoTile(Icons.email, 'E-posta', 'gul@gmail.com'),
              _buildInfoTile(Icons.phone, 'Telefon', '+90 555 123 4567'),
              _buildInfoTile(Icons.location_on, 'Adres', 'Kadıköy, İstanbul'),
              _buildInfoTile(Icons.cake, 'Doğum Tarihi', '15 Ocak 2000'),
            ]),

            const SizedBox(height: 20),

            // Hesap Güvenliği
            _buildSectionCard('Hesap Güvenliği', [
              _buildActionTile(Icons.lock_outline, 'Şifre Değiştir', () {}),
              _buildActionTile(Icons.security, 'Güvenlik Ayarları', () {}),
              _buildActionTile(Icons.privacy_tip_outlined, 'Gizlilik', () {}),
            ]),

            const SizedBox(height: 20),

            // Diğer İşlemler
            _buildSectionCard('Diğer İşlemler', [
              _buildActionTile(Icons.favorite_outline, 'Favori Ürünler', () {}),
              _buildActionTile(Icons.credit_card, 'Ödeme Yöntemleri', () {}),
              _buildActionTile(Icons.support_agent, 'Destek', () {}),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Appcolor.buttonColor, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Appcolor.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Appcolor.white.withOpacity(0.7),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                color: Appcolor.buttonColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Appcolor.buttonColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Appcolor.buttonColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Appcolor.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Appcolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Appcolor.buttonColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Appcolor.buttonColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Appcolor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Appcolor.white.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
