import 'package:cinemaa/screens/bottoms/home.dart';
import 'package:cinemaa/screens/tickets/seat_selection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectShowtimePage extends StatefulWidget {
  final String movieTitle;
  final String moviePoster;
  final DateTime selectedDate;
  final Film film;

  const SelectShowtimePage({
    Key? key,
    required this.movieTitle,
    required this.moviePoster,
    required this.selectedDate,
    required this.film,
  }) : super(key: key);

  @override
  _SelectShowtimePageState createState() => _SelectShowtimePageState();
}

class _SelectShowtimePageState extends State<SelectShowtimePage> {
  // Örnek sinema salonları
  final List<Map<String, dynamic>> _theaters = [
    {
      'name': 'Cinema City Kanyon',
      'showtimes': ['10:30', '13:45', '16:20', '19:00', '21:30'],
    },
    {
      'name': 'Cinemaximum İstinyePark',
      'showtimes': ['11:15', '14:00', '16:45', '19:30', '22:15'],
    },
    {
      'name': 'Movieplex Forum',
      'showtimes': ['12:00', '15:00', '18:00', '21:00'],
    },
  ];

  int? _selectedTheaterIndex;
  String? _selectedShowtime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seans Seçin',
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          DateFormat(
                            'd MMMM yyyy, EEEE',
                          ).format(widget.selectedDate),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sinema Salonları',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Sinema salonları ve seansları
                    for (int i = 0; i < _theaters.length; i++) ...[
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color.fromARGB(255, 10, 222, 230),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _theaters[i]['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (String time in _theaters[i]['showtimes'])
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedTheaterIndex = i;
                                        _selectedShowtime = time;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient:
                                            _selectedTheaterIndex == i &&
                                                    _selectedShowtime == time
                                                ? LinearGradient(
                                                  colors: [
                                                    const Color.fromARGB(
                                                      255,
                                                      9,
                                                      14,
                                                      10,
                                                    ),
                                                    const Color.fromARGB(
                                                      255,
                                                      118,
                                                      113,
                                                      167,
                                                    ),
                                                  ],
                                                )
                                                : null,
                                        color:
                                            _selectedTheaterIndex == i &&
                                                    _selectedShowtime == time
                                                ? null
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color:
                                              _selectedTheaterIndex == i &&
                                                      _selectedShowtime == time
                                                  ? const Color.fromARGB(
                                                    255,
                                                    10,
                                                    222,
                                                    230,
                                                  )
                                                  : Colors.grey.shade300,
                                          width:
                                              _selectedTheaterIndex == i &&
                                                      _selectedShowtime == time
                                                  ? 1.5
                                                  : 1,
                                        ),
                                      ),
                                      child: Text(
                                        time,
                                        style: TextStyle(
                                          color:
                                              _selectedTheaterIndex == i &&
                                                      _selectedShowtime == time
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            // Devam butonu
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap:
                    _selectedTheaterIndex != null && _selectedShowtime != null
                        ? () {
                          // Koltuk seçim sayfasına git
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SeatSelectionPage(
                                    movieTitle: widget.movieTitle,
                                    moviePoster: widget.moviePoster,
                                    selectedDate: widget.selectedDate,
                                    theaterName:
                                        _theaters[_selectedTheaterIndex!]['name'],
                                    showtime: _selectedShowtime!,
                                    film: widget.film,
                                  ),
                            ),
                          );
                        }
                        : null,
                child: Opacity(
                  opacity:
                      _selectedTheaterIndex != null && _selectedShowtime != null
                          ? 1.0
                          : 0.5,
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
            ),
          ],
        ),
      ),
    );
  }
}
