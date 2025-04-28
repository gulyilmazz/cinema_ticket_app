import 'package:cinemaa/models/film_model.dart';
import 'package:cinemaa/screens/tickets/confirmation_page.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String movieTitle;
  final String moviePoster;
  final int totalAmount;
  final int selectedSeats;
  final DateTime selectedDate;
  final String showtime;
  final String theaterName;
  final Film film;

  const PaymentPage({
    Key? key,
    required this.movieTitle,
    required this.moviePoster,
    required this.totalAmount,
    required this.selectedSeats,
    required this.selectedDate,
    required this.showtime,
    required this.theaterName,
    required this.film,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ödeme',
          style: TextStyle(
            color: const Color.fromARGB(255, 10, 223, 230),
            fontSize: 18,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 9, 14, 10),
                const Color.fromARGB(255, 118, 113, 167),
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 10, 223, 230),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 152, 147, 196),
              const Color.fromARGB(255, 211, 208, 218),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ödeme Bilgileri',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            _buildTextField(
              labelText: 'Kart Numarası',
              onChanged: (value) {
                setState(() {});
              },
            ),
            _buildTextField(
              labelText: 'Son Kullanma Tarihi (MM/YY)',
              onChanged: (value) {
                setState(() {});
              },
            ),
            _buildTextField(
              labelText: 'CVV',
              onChanged: (value) {
                setState(() {});
              },
            ),
            _buildTextField(
              labelText: 'Kart Üzerindeki İsim',
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processPayment,
              child: Text('Ödeme Yap'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 10, 223, 230),
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  void _processPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ConfirmationPage(
              movieTitle: widget.movieTitle,
              moviePoster: widget.moviePoster,
              totalAmount: widget.totalAmount,
              selectedSeats: widget.selectedSeats,
              selectedDate: widget.selectedDate,
              showtime: widget.showtime,
              theaterName: widget.theaterName,
              film: widget.film,
            ),
      ),
    );
  }
}
