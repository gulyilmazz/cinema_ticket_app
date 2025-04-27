import 'package:cinemaa/screens/bottoms/home.dart';
import 'package:cinemaa/screens/tickets/select_showtime.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BiletsScreen extends StatefulWidget {
  final String movieTitle;
  final String moviePoster;
  final Film film;

  const BiletsScreen({
    Key? key,
    required this.movieTitle,
    required this.moviePoster,
    required this.film,
  }) : super(key: key);

  @override
  _BiletsScreenState createState() => _BiletsScreenState();
}

class _BiletsScreenState extends State<BiletsScreen> {
  final List<DateTime> _availableDates = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Sonraki 7 günü kullanılabilir tarihler olarak ayarla
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      _availableDates.add(now.add(Duration(days: i)));
    }
    _selectedDate = _availableDates.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: Text(
                  widget.movieTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Tarih Seçin',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Tarih seçimi
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _availableDates.length,
            itemBuilder: (context, index) {
              final date = _availableDates[index];
              final isSelected = _selectedDate == date;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Container(
                  width: 70,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    gradient:
                        isSelected
                            ? LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 9, 14, 10),
                                const Color.fromARGB(255, 118, 113, 167),
                              ],
                            )
                            : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isSelected
                              ? const Color.fromARGB(255, 10, 222, 230)
                              : Colors.grey,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        DateFormat('d').format(date),
                        style: TextStyle(
                          fontSize: 20,
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        DateFormat('MMM').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        // Devam butonu
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            onTap: () {
              // Seans seçim sayfasına git
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SelectShowtimePage(
                        movieTitle: widget.movieTitle,
                        moviePoster: widget.moviePoster,
                        selectedDate: _selectedDate!,
                        film: widget.film,
                      ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
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
              child: Center(
                child: Text(
                  'Devam Et',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
