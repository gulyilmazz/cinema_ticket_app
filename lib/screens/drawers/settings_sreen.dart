import 'package:flutter/material.dart';

class Appcolor {
  static const appBackgroundColor = Color(0xFF1c1c27);
  static const grey = Color(0xFF373741);
  static const buttonColor = Color(0xFFffb43b);
  static const white = Colors.white;
  static const darkGrey = Color(0xFF252532);
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool locationEnabled = true;
  bool darkModeEnabled = true;
  String selectedLanguage = 'Türkçe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Ayarlar',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bildirim Ayarları
          _buildSectionCard('Bildirim Ayarları', Icons.notifications, [
            _buildSwitchTile(
              'Push Bildirimleri',
              'Sipariş durumu bildirimleri',
              notificationsEnabled,
              (value) => setState(() => notificationsEnabled = value),
            ),
            _buildSwitchTile(
              'E-posta Bildirimleri',
              'Kampanya ve duyuru e-postaları',
              emailNotifications,
              (value) => setState(() => emailNotifications = value),
            ),
            _buildSwitchTile(
              'SMS Bildirimleri',
              'Önemli güncellemeler için SMS',
              smsNotifications,
              (value) => setState(() => smsNotifications = value),
            ),
          ]),

          const SizedBox(height: 20),

          // Uygulama Ayarları
          _buildSectionCard('Uygulama Ayarları', Icons.settings, [
            _buildSwitchTile(
              'Koyu Tema',
              'Karanlık arayüz kullan',
              darkModeEnabled,
              (value) => setState(() => darkModeEnabled = value),
            ),
            _buildSwitchTile(
              'Konum Hizmetleri',
              'Yakındaki restoranları bul',
              locationEnabled,
              (value) => setState(() => locationEnabled = value),
            ),
            _buildSelectTile(
              Icons.language,
              'Dil',
              'Uygulama dili',
              selectedLanguage,
              () => _showLanguageDialog(),
            ),
          ]),

          const SizedBox(height: 20),

          // Hesap Ayarları
          _buildSectionCard('Hesap Ayarları', Icons.account_circle, [
            _buildActionTile(
              Icons.credit_card,
              'Ödeme Yöntemleri',
              'Kayıtlı kart ve ödeme seçenekleri',
              () => _showFeatureDialog('Ödeme Yöntemleri'),
            ),
            _buildActionTile(
              Icons.location_city,
              'Adreslerim',
              'Kayıtlı teslimat adresleri',
              () => _showFeatureDialog('Adreslerim'),
            ),
          ]),

          const SizedBox(height: 20),

          // Güvenlik
          _buildSectionCard('Güvenlik', Icons.security, [
            _buildActionTile(
              Icons.lock,
              'Şifre Değiştir',
              'Hesap şifrenizi güncelleyin',
              () => _showFeatureDialog('Şifre Değiştir'),
            ),
            _buildActionTile(
              Icons.fingerprint,
              'Biyometrik Giriş',
              'Parmak izi veya yüz tanıma',
              () => _showFeatureDialog('Biyometrik Giriş'),
            ),
            _buildActionTile(
              Icons.privacy_tip,
              'Gizlilik Ayarları',
              'Veri paylaşım tercihleri',
              () => _showFeatureDialog('Gizlilik Ayarları'),
            ),
          ]),

          const SizedBox(height: 20),

          // Destek ve Yardım
          _buildSectionCard('Destek ve Yardım', Icons.help, [
            _buildActionTile(
              Icons.help_center,
              'Yardım Merkezi',
              'Sık sorulan sorular ve rehberler',
              () => _showFeatureDialog('Yardım Merkezi'),
            ),
            _buildActionTile(
              Icons.contact_support,
              'İletişim',
              'Müşteri hizmetleri ile iletişim',
              () => _showFeatureDialog('Müşteri Hizmetleri'),
            ),
            _buildActionTile(
              Icons.bug_report,
              'Sorun Bildir',
              'Uygulama sorunlarını bildirin',
              () => _showFeatureDialog('Sorun Bildir'),
            ),
            _buildActionTile(
              Icons.star_rate,
              'Uygulamayı Değerlendir',
              'Play Store\'da puan verin',
              () => _showFeatureDialog('Uygulama Değerlendirme'),
            ),
          ]),

          const SizedBox(height: 20),

          // Hakkında
          _buildSectionCard('Hakkında', Icons.info, [
            _buildInfoTile(Icons.info_outline, 'Uygulama Versiyonu', '2.1.5'),
            _buildActionTile(
              Icons.description,
              'Kullanım Şartları',
              'Hizmet kullanım koşulları',
              () => _showFeatureDialog('Kullanım Şartları'),
            ),
            _buildActionTile(
              Icons.policy,
              'Gizlilik Politikası',
              'Veri koruma ve gizlilik',
              () => _showFeatureDialog('Gizlilik Politikası'),
            ),
          ]),

          const SizedBox(height: 30),

          // Çıkış Yap Butonu
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.5)),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showLogoutDialog(),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red.shade400),
                      const SizedBox(width: 12),
                      Text(
                        'Çıkış Yap',
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section Card Builder
  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, color: Appcolor.buttonColor, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Appcolor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  // Switch Tile Builder
  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Appcolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Appcolor.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Appcolor.buttonColor,
            inactiveThumbColor: Appcolor.grey,
            inactiveTrackColor: Appcolor.grey.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  // Select Tile Builder
  Widget _buildSelectTile(
    IconData icon,
    String title,
    String subtitle,
    String value,
    VoidCallback onTap,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(icon, color: Appcolor.buttonColor, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Appcolor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Appcolor.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Appcolor.buttonColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                color: Appcolor.white.withOpacity(0.4),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Action Tile Builder
  Widget _buildActionTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(icon, color: Appcolor.buttonColor, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Appcolor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Appcolor.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Appcolor.white.withOpacity(0.4),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Info Tile Builder
  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: Appcolor.buttonColor, size: 24),
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
            Text(
              value,
              style: TextStyle(
                color: Appcolor.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Language Selection Dialog
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Appcolor.darkGrey,
          title: const Text(
            'Dil Seçin',
            style: TextStyle(color: Appcolor.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('Türkçe'),
              _buildLanguageOption('English'),
              _buildLanguageOption('العربية'),
              _buildLanguageOption('Deutsch'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile<String>(
      title: Text(language, style: const TextStyle(color: Appcolor.white)),
      value: language,
      groupValue: selectedLanguage,
      activeColor: Appcolor.buttonColor,
      onChanged: (String? value) {
        setState(() {
          selectedLanguage = value!;
        });
        Navigator.of(context).pop();
      },
    );
  }

  // Feature Dialog (Placeholder for future implementations)
  void _showFeatureDialog(String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Appcolor.darkGrey,
          title: Text(feature, style: const TextStyle(color: Appcolor.white)),
          content: Text(
            'Bu özellik yakında kullanıma sunulacak.',
            style: TextStyle(color: Appcolor.white.withOpacity(0.8)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Tamam',
                style: TextStyle(color: Appcolor.buttonColor),
              ),
            ),
          ],
        );
      },
    );
  }

  // Logout Confirmation Dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Appcolor.darkGrey,
          title: const Text(
            'Çıkış Yap',
            style: TextStyle(color: Appcolor.white),
          ),
          content: Text(
            'Hesabınızdan çıkış yapmak istediğinizden emin misiniz?',
            style: TextStyle(color: Appcolor.white.withOpacity(0.8)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'İptal',
                style: TextStyle(color: Appcolor.white.withOpacity(0.8)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Logout işlemi burada yapılacak
                _performLogout();
              },
              child: Text(
                'Çıkış Yap',
                style: TextStyle(color: Colors.red.shade400),
              ),
            ),
          ],
        );
      },
    );
  }

  // Logout Implementation
  void _performLogout() {
    // Logout işlemi burada implement edilecek
    // Örneğin: AuthService.logout(), SharedPreferences temizle, vb.

    // Geçici olarak bir snackbar göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Çıkış yapıldı'),
        backgroundColor: Appcolor.buttonColor,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Ana sayfaya veya login sayfasına yönlendir
    // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
}
