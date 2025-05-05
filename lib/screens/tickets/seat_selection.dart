import 'package:cinemaa/models/film_model.dart';
import 'package:cinemaa/screens/tickets/payment_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeatSelectionPage extends StatefulWidget {
  final String movieTitle;
  final String moviePoster;
  final DateTime selectedDate;
  final String theaterName;
  final String showtime;
  final Film film;

  const SeatSelectionPage({
    super.key,
    required this.movieTitle,
    required this.moviePoster,
    required this.selectedDate,
    required this.theaterName,
    required this.showtime,
    required this.film,
  });

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  // Koltuk durumları: 0 = boş, 1 = dolu, 2 = seçili
  final List<List<int>> _seats = List.generate(
    10,
    (row) => List.generate(
      8,
      (col) => (row == 0 || col == 0 || row == 9 || col == 7) ? 1 : 0,
    ),
  );

  int _selectedSeatsCount = 0;
  final int _ticketPrice = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Koltuk Seçin',
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
        child: Column(
          children: [
            // Film bilgisi
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.black12,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromARGB(255, 10, 222, 230),
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage(widget.moviePoster),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movieTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${DateFormat('d MMMM yyyy').format(widget.selectedDate)} - ${widget.showtime}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 2),
                        Text(
                          widget.theaterName,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Lejant
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(Colors.grey.shade300, 'Boş'),
                  _buildLegendItem(
                    const Color.fromARGB(255, 118, 113, 167),
                    'Seçili',
                  ),
                  _buildLegendItem(Colors.grey.shade700, 'Dolu'),
                ],
              ),
            ),
            // Perde
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    118,
                    113,
                    167,
                  ).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color.fromARGB(255, 10, 222, 230),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'PERDE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Koltuk yerleşimi
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 8 * 10,
                itemBuilder: (context, index) {
                  final row = index ~/ 8;
                  final col = index % 8;
                  final seatStatus = _seats[row][col];

                  // Geçiş koridoru
                  if (col == 3) {
                    return SizedBox();
                  }

                  // Koltuk
                  return GestureDetector(
                    onTap:
                        seatStatus == 1
                            ? null
                            : () {
                              setState(() {
                                if (_seats[row][col] == 0) {
                                  _seats[row][col] = 2;
                                  _selectedSeatsCount++;
                                } else if (_seats[row][col] == 2) {
                                  _seats[row][col] = 0;
                                  _selectedSeatsCount--;
                                }
                              });
                            },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            seatStatus == 0
                                ? Colors.grey.shade300
                                : seatStatus == 1
                                ? Colors.grey.shade700
                                : const Color.fromARGB(255, 118, 113, 167),
                        borderRadius: BorderRadius.circular(4),
                        border:
                            seatStatus == 2
                                ? Border.all(
                                  color: const Color.fromARGB(
                                    255,
                                    10,
                                    222,
                                    230,
                                  ),
                                  width: 1,
                                )
                                : null,
                      ),
                      child: Center(
                        child: Text(
                          '${String.fromCharCode(65 + row)}${col + 1}',
                          style: TextStyle(
                            color:
                                seatStatus == 0 ? Colors.black : Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Alt bilgi
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.black12,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_selectedSeatsCount Koltuk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Toplam: ${_selectedSeatsCount * _ticketPrice} TL',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 10, 223, 230),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap:
                        _selectedSeatsCount > 0
                            ? () {
                              // Ödeme sayfasına git
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => PaymentPage(
                                        movieTitle: widget.movieTitle,
                                        moviePoster: widget.moviePoster,
                                        totalAmount:
                                            _selectedSeatsCount * _ticketPrice,
                                        selectedSeats: _selectedSeatsCount,
                                        selectedDate: widget.selectedDate,
                                        showtime: widget.showtime,
                                        theaterName: widget.theaterName,
                                        film: widget.film,
                                      ),
                                ),
                              );
                            }
                            : null,
                    child: Opacity(
                      opacity: _selectedSeatsCount > 0 ? 1.0 : 0.5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 9, 14, 10),
                              const Color.fromARGB(255, 118, 113, 167),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 10, 222, 230),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          'Devam Et',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
