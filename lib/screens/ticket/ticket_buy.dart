import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/services/ticket/ticket_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/ticket_response.dart';

class TicketCreatePage extends StatefulWidget {
  final String showtimeId;
  final String seatNumber;

  const TicketCreatePage({
    Key? key,
    required this.showtimeId,
    required this.seatNumber,
  }) : super(key: key);

  @override
  _TicketCreatePageState createState() => _TicketCreatePageState();
}

class _TicketCreatePageState extends State<TicketCreatePage> {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  final TicketsService _ticketsService = TicketsService();

  Future<void> _createTicket(BuildContext context) async {
    final userId = await AuthStorage.getUserId();
    final token = await AuthStorage.getToken();
    if (token == null) {
      // No token handling
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
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
          _successMessage =
              'Bilet başarıyla oluşturuldu! Bilet Kodu: ${response.data?.ticketCode}';
        } else {
          _errorMessage = response.message ?? 'Bilet oluşturma başarısız.';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilet Onayı'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seçilen Seans: ${widget.showtimeId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Koltuk Numarası: ${widget.seatNumber}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                  onPressed: () => _createTicket(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Bileti Oluştur'),
                ),
            const SizedBox(height: 16),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            if (_successMessage != null)
              Text(
                _successMessage!,
                style: const TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
