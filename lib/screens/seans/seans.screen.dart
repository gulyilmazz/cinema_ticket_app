import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/models/seans_response.dart';
import 'package:cinemaa/screens/seats/seats_screen.dart';
import 'package:cinemaa/services/seans/seans_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeansPage extends StatefulWidget {
  final int hallId;

  const SeansPage({super.key, required this.hallId});

  @override
  State<SeansPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SeansPage> {
  final SeansService _sessionService = SeansService();
  bool _isLoading = true;
  List<SeansResponse> _sessions = [];
  String? _errorMessage;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchSessions();
  }

  Future<void> _fetchSessions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await AuthStorage.getToken();

      if (token == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Authentication required';
          });
        }
        return;
      }

      final response = await _sessionService.getSeanslar(
        token: token,
        hallId: widget.hallId,
      );

      setState(() {
        if (response.success == true) {
          _sessions = response.data ?? [];
        } else {
          _sessions = [];
        }
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'An error occurred: ${e.toString()}';
        });
      }
    }
  }

  Widget _buildDateSelector() {
    final now = DateTime.now();
    final dates = List.generate(
      7,
      (index) => DateTime(now.year, now.month, now.day + index),
    );

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected =
              DateFormat('yyyy-MM-dd').format(date) ==
              DateFormat('yyyy-MM-dd').format(_selectedDate);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              _fetchSessions();
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Appcolor.buttonColor : Appcolor.darkGrey,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color:
                        isSelected
                            ? Appcolor.buttonColor.withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? Appcolor.appBackgroundColor
                              : Appcolor.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? Appcolor.appBackgroundColor
                              : Appcolor.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          isSelected
                              ? Appcolor.appBackgroundColor.withValues(
                                alpha: 0.8,
                              )
                              : Appcolor.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.darkGrey,
        title: const Text('Seanslar', style: TextStyle(color: Appcolor.white)),
        iconTheme: const IconThemeData(color: Appcolor.buttonColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Appcolor.buttonColor),
            onPressed: _fetchSessions,
          ),
        ],
      ),
      body: Column(
        children: [_buildDateSelector(), Expanded(child: _buildSessionsList())],
      ),
    );
  }

  Widget _buildSessionsList() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Appcolor.buttonColor),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchSessions,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.buttonColor,
                foregroundColor: Appcolor.appBackgroundColor,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_sessions.isEmpty) {
      return const Center(
        child: Text(
          'Bu tarih için seans bulunamadı',
          style: TextStyle(color: Appcolor.white),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchSessions,
      color: Appcolor.buttonColor,
      backgroundColor: Appcolor.darkGrey,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sessions.length,
        itemBuilder: (context, index) {
          final session = _sessions[index];
          return SessionCard(
            session: session,
            onTap: () async {
              // Get token for SeatSelectionScreen
              final token = await AuthStorage.getToken();
              if (token != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => SeatSelectionScreen(
                          hallId: widget.hallId,
                          showtimeId: session.id!,
                        ),
                  ),
                );
              } else {
                // Handle case when token is not available
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Authentication required'),
                    backgroundColor: Appcolor.darkGrey,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final SeansResponse session;
  final VoidCallback onTap;

  const SessionCard({super.key, required this.session, required this.onTap});

  String _formatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return 'N/A';

    try {
      final time = DateTime.parse(timeString);
      return DateFormat('HH:mm').format(time);
    } catch (e) {
      // If parsing fails, return as is or try a different format
      return timeString;
    }
  }

  double _parsePrice(String? priceString) {
    if (priceString == null || priceString.isEmpty) return 0.0;

    try {
      return double.parse(priceString);
    } catch (e) {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 6,
      color: Appcolor.darkGrey,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      session.movie?.title ?? 'Unknown Movie',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.buttonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _formatTime(session.startTime),
                      style: const TextStyle(
                        color: Appcolor.appBackgroundColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.movie,
                    size: 16,
                    color: Appcolor.buttonColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Süre: ${session.movie?.duration ?? 'N/A'} dk',
                    style: TextStyle(
                      color: Appcolor.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.attach_money,
                    size: 16,
                    color: Appcolor.buttonColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Fiyat: ${_parsePrice(session.price).toStringAsFixed(2)} TL',
                    style: TextStyle(
                      color: Appcolor.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.event_seat,
                    size: 16,
                    color: Appcolor.buttonColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Boş Koltuk: ${session.availableSeats ?? 'N/A'}',
                    style: TextStyle(
                      color: Appcolor.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              if (session.movie?.genre != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.category,
                      size: 16,
                      color: Appcolor.buttonColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Tür: ${session.movie!.genre}',
                      style: TextStyle(
                        color: Appcolor.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
              if (session.movie?.language != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      size: 16,
                      color: Appcolor.buttonColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Dil: ${session.movie!.language}',
                      style: TextStyle(
                        color: Appcolor.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
