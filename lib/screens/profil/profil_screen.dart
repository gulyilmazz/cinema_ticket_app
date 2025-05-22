import 'package:flutter/material.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});
  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final Color cyanAccent = const Color(0xFF00E5E5);

  // Bright cyan color
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Base background color
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileHeader(),
                      _buildAccountInfoSection(),
                      SizedBox(height: 12),
                      _buildSettingsButtons(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade900)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profil',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Icon(Icons.edit, color: cyanAccent, size: 20),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: cyanAccent,
            child: Icon(Icons.person, size: 40, color: Colors.black),
          ),
          SizedBox(height: 16),
          Text(
            'Gül Yılmaz',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'gul.yilmaz@gmail.com',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Text(
                '14',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: cyanAccent,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Favoriler',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: cyanAccent, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hesap Bilgileri',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: cyanAccent,
            ),
          ),
          SizedBox(height: 16),
          _buildInfoRow('Ad Soyad:', 'Gül Yılmaz'),
          SizedBox(height: 12),
          _buildInfoRow('Telefon:', '+90 555 123 4567'),
          SizedBox(height: 12),
          _buildInfoRow('Doğum Tarihi:', '15.06.1990'),
          SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              icon: Icon(Icons.edit, color: cyanAccent, size: 18),
              label: Text(
                'Düzenle',
                style: TextStyle(color: cyanAccent, fontSize: 14),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsButtons() {
    return Column(
      children: [
        _buildSettingButton('Ödeme Yöntemleri', Icons.credit_card),
        SizedBox(height: 2),
        _buildSettingButton('Bildirim Ayarları', Icons.notifications_none),
        SizedBox(height: 2),
        _buildSettingButton('Dil Seçenekleri', Icons.language),
      ],
    );
  }

  Widget _buildSettingButton(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.black,
            Color(
              0xFF7B68EE,
            ).withValues(alpha: 0.7), // Purple-blue shade matching menu
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: cyanAccent.withValues(alpha: 0.5), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              children: [
                Icon(icon, size: 22, color: cyanAccent),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
