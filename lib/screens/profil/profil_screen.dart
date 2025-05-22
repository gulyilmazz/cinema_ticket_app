import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/screens/auth/login_screen.dart';
import 'package:cinemaa/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/profile_response.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final ProfileService _profileService = ProfileService();
  ProfileData? _profileData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      final token = await AuthStorage.getToken();
      if (token == null) {
        setState(() {
          _errorMessage = 'Token bulunamadı';
          _isLoading = false;
        });
        return;
      }

      final response = await _profileService.getProfile(token: token);

      if (response.success == true && response.data != null) {
        setState(() {
          _profileData = response.data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Profil bilgileri alınamadı';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Bir hata oluştu: $e';
        _isLoading = false;
      });
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Appcolor.darkGrey,
          title: Text('Çıkış Yap', style: TextStyle(color: Appcolor.white)),
          content: Text(
            'Çıkış yapmak istediğinizden emin misiniz?',
            style: TextStyle(color: Appcolor.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Appcolor.white)),
            ),
            TextButton(
              onPressed: () {
                AuthStorage.clearToken();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Çıkış Yap',
                style: TextStyle(color: Appcolor.buttonColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child:
                  _isLoading
                      ? _buildLoadingWidget()
                      : _errorMessage != null
                      ? _buildErrorWidget()
                      : _buildProfileContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        border: Border(bottom: BorderSide(color: Appcolor.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profil',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Appcolor.white,
            ),
          ),
          IconButton(
            onPressed: _loadProfile,
            icon: Icon(Icons.refresh, color: Appcolor.buttonColor, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Appcolor.buttonColor),
          SizedBox(height: 16),
          Text(
            'Profil bilgileri yükleniyor...',
            style: TextStyle(color: Appcolor.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 64),
            SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Appcolor.white, fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.buttonColor,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Tekrar Dene',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    if (_profileData == null) return Container();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfileHeader(),
          SizedBox(height: 32),
          _buildProfileInfo(),
          SizedBox(height: 32),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Appcolor.grey, width: 0.5),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Appcolor.buttonColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, size: 40, color: Colors.black),
          ),
          SizedBox(height: 16),
          Text(
            _profileData?.name ?? 'Kullanıcı',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Appcolor.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _profileData?.email ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Appcolor.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Appcolor.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hesap Bilgileri',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Appcolor.buttonColor,
            ),
          ),
          SizedBox(height: 20),
          _buildInfoRow('Kullanıcı ID:', _profileData?.id?.toString() ?? '-'),
          SizedBox(height: 16),
          _buildInfoRow('Ad Soyad:', _profileData?.name ?? '-'),
          SizedBox(height: 16),
          _buildInfoRow('E-posta:', _profileData?.email ?? '-'),
          SizedBox(height: 16),
          _buildInfoRow('Rol:', _profileData?.roleName ?? '-'),
          if (_profileData?.createdAt != null) ...[
            SizedBox(height: 16),
            _buildInfoRow(
              'Kayıt Tarihi:',
              _formatDate(_profileData!.createdAt!),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: Appcolor.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _logout,
        icon: Icon(Icons.logout, color: Colors.black),
        label: Text(
          'Çıkış Yap',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.buttonColor,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
