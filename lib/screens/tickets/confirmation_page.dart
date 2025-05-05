import 'package:cinemaa/models/movies_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmationPage extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  final int selectedSeats;
  final int totalAmount;
  final DateTime selectedDate;
  final String showtime;
  final String theaterName;
  final Film? film;

  const ConfirmationPage({
    super.key,
    required this.movieTitle,
    required this.moviePoster,
    required this.selectedSeats,
    required this.totalAmount,
    required this.selectedDate,
    required this.showtime,
    required this.theaterName,
    this.film,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilet Onayı'),
        automaticallyImplyLeading: false, // Geri butonunu kaldırır
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Tebrikler!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Bilet rezervasyonunuz başarıyla tamamlanmıştır.',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: Image.asset(moviePoster, height: 150.0, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16.0),
            Text(
              movieTitle,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            _buildConfirmationItem(
              'Tarih',
              DateFormat('dd MMMM yyyy', 'tr_TR').format(selectedDate),
            ),
            _buildConfirmationItem('Seans', showtime),
            _buildConfirmationItem('Salon', theaterName),
            _buildConfirmationItem('Bilet Sayısı', '$selectedSeats'),
            _buildConfirmationItem('Toplam Tutar', '$totalAmount TL'),
            const SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Ana sayfaya veya biletlerim sayfasına yönlendirme yapılabilir.
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Ana Sayfaya Dön',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
