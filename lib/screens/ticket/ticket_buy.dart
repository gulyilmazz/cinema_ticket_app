import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/services/ticket/ticket_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/ticket_response.dart';

class TicketCreatePage extends StatefulWidget {
  final String showtimeId;
  final String seatNumber;

  const TicketCreatePage({
    super.key,
    required this.showtimeId,
    required this.seatNumber,
  });

  @override
  State<TicketCreatePage> createState() => _TicketCreatePageState();
}

class _TicketCreatePageState extends State<TicketCreatePage>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  String? _errorMessage;
  TicketData? _ticketData;
  final TicketsService _ticketsService = TicketsService();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _createTicket(BuildContext context) async {
    final userId = await AuthStorage.getUserId();
    final token = await AuthStorage.getToken();

    if (token == null) {
      setState(() {
        _errorMessage = 'Oturum bilgisi bulunamadı. Lütfen tekrar giriş yapın.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _ticketData = null;
    });

    try {
      final response = await _ticketsService.addTicket(
        token: token.toString(),
        userId: userId.toString(),
        showtimeId: widget.showtimeId,
        seatNumber: widget.seatNumber,
      );

      setState(() {
        _isLoading = false;
        if (response.success == true) {
          _ticketData = response.data;
        } else {
          _errorMessage = response.message ?? 'Bilet oluşturma başarısız.';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Bir hata oluştu: ${e.toString()}';
      });
    }
  }

  Widget _buildTicketCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Appcolor.darkGrey, Appcolor.grey],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Appcolor.buttonColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Appcolor.buttonColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.movie,
                    color: Appcolor.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Bilet Onayı',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildInfoRow(
                  Icons.event_seat,
                  'Koltuk Numarası',
                  widget.seatNumber,
                ),
                const SizedBox(height: 20),
                _buildInfoRow(Icons.schedule, 'Seans ID', widget.showtimeId),
                const SizedBox(height: 32),

                if (_ticketData != null) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Bilet Başarıyla Oluşturuldu!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        _buildTicketInfo(),
                      ],
                    ),
                  ),
                ] else if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Biletinizi oluşturmak için aşağıdaki butona tıklayın',
                    style: TextStyle(fontSize: 16, color: Appcolor.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Appcolor.appBackgroundColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Appcolor.buttonColor.withValues(alpha: 0.2),
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
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Appcolor.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInfo() {
    return Column(
      children: [
        if (_ticketData?.ticketCode != null) ...[
          _buildTicketDetail('Bilet Kodu', _ticketData!.ticketCode!),
          const SizedBox(height: 12),
        ],
        if (_ticketData?.price != null) ...[
          _buildTicketDetail('Fiyat', '${_ticketData!.price} ₺'),
          const SizedBox(height: 12),
        ],
        if (_ticketData?.createdAt != null)
          _buildTicketDetail('Oluşturulma Tarihi', _ticketData!.createdAt!),
      ],
    );
  }

  Widget _buildTicketDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Appcolor.white.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Appcolor.white,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    if (_ticketData != null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.home),
          label: const Text(
            'Ana Sayfaya Dön',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Appcolor.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : () => _createTicket(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.buttonColor,
          foregroundColor: Appcolor.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: Appcolor.buttonColor.withValues(alpha: 0.3),
        ),
        child:
            _isLoading
                ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Appcolor.white),
                  ),
                )
                : const Text(
                  'Bileti Oluştur',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Appcolor.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Bilet İşlemleri',
          style: TextStyle(color: Appcolor.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(child: _buildTicketCard()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: _buildActionButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
