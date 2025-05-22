import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/models/seats_response.dart';
import 'package:cinemaa/screens/ticket/ticket_buy.dart';
import 'package:cinemaa/services/seat/seat_service.dart';
import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  final int hallId;
  final int showtimeId;

  const SeatSelectionScreen({
    super.key,
    required this.hallId,
    required this.showtimeId,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late Future<SeatResponse> _seatResponseFuture;
  final SeatsService seatsService = SeatsService();

  final Set<String> _selectedSeatIds = {};
  List<Seat> _allSeats = [];

  @override
  void initState() {
    super.initState();
    _seatResponseFuture = _loadSeats();
  }

  Future<SeatResponse> _loadSeats() async {
    final token = await AuthStorage.getToken();
    if (token == null) {
      // No token handling
    }
    return seatsService.getSeast(
      hallId: widget.hallId,
      token: token.toString(),
    );
  }

  void _toggleSeatSelection(Seat seat) {
    if (seat.status.toLowerCase() == 'available' &&
        seat.type.toLowerCase() != 'disabled') {
      setState(() {
        if (_selectedSeatIds.contains(seat.id)) {
          _selectedSeatIds.remove(seat.id);
        } else {
          _selectedSeatIds.add(seat.id);
        }
      });
    } else {
      _showMessage(
        seat.type.toLowerCase() == 'disabled'
            ? 'Bu koltuk engelli koltuğudur ve seçilemez'
            : 'Bu koltuk (${seat.status}) seçilemez',
        isError: true,
      );
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? Colors.red : Appcolor.darkGrey,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Color _getSeatColor(Seat seat, bool isSelected) {
    if (isSelected) return Appcolor.buttonColor;

    switch (seat.status.toLowerCase()) {
      case 'available':
        if (seat.type.toLowerCase() == 'premium' ||
            seat.type.toLowerCase() == 'vip')
          return const Color(0xFF8B4513); // Brown for VIP
        if (seat.type.toLowerCase() == 'disabled') return Appcolor.grey;
        return Appcolor.darkGrey;
      case 'booked':
      case 'sold':
        return Appcolor.grey;
      default:
        return Appcolor.grey.withOpacity(0.3);
    }
  }

  Widget _buildSeatWidget(Seat seat, bool isSelected) {
    final seatColor = _getSeatColor(seat, isSelected);
    final borderColor =
        isSelected ? Appcolor.white : seatColor.withOpacity(0.7);

    // Determine seat status for visualization
    final bool isSold =
        seat.status.toLowerCase() == 'sold' ||
        seat.status.toLowerCase() == 'booked';
    final bool isDisabled = seat.type.toLowerCase() == 'disabled';
    final bool isPremium =
        seat.type.toLowerCase() == 'premium' ||
        seat.type.toLowerCase() == 'vip';

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: seatColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: isSelected ? 2 : 1.5),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Appcolor.buttonColor.withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ]
                : null,
      ),
      child: Stack(
        children: [
          // Main seat icon or marker
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isSold ? 0.5 : 1.0,
              child: _buildSeatIndicator(
                isSold,
                isDisabled,
                isPremium,
                isSelected,
              ),
            ),
          ),

          // Seat ID at the bottom
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                seat.id,
                style: TextStyle(
                  color: Appcolor.white.withOpacity(0.9),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatIndicator(
    bool isSold,
    bool isDisabled,
    bool isPremium,
    bool isSelected,
  ) {
    // For disabled seats
    if (isDisabled) {
      return Icon(
        Icons.accessible,
        size: 18,
        color: Appcolor.white.withOpacity(0.7),
      );
    }

    // For sold seats
    if (isSold) {
      return Container(
        width: 18,
        height: 2,
        decoration: BoxDecoration(
          color: Appcolor.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(1),
        ),
      );
    }

    // For premium/VIP seats
    if (isPremium) {
      return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          border: Border.all(
            color: Appcolor.white.withOpacity(0.85),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Appcolor.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      );
    }

    // For selected seats
    if (isSelected) {
      return Icon(Icons.check, size: 18, color: Appcolor.white);
    }

    // For regular available seats
    return Container(
      width: 22,
      height: 14,
      decoration: BoxDecoration(
        border: Border.all(color: Appcolor.white.withOpacity(0.7), width: 1.2),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  List<Seat> get _selectedSeatsObjects {
    if (_allSeats.isEmpty) return [];
    return _allSeats
        .where((seat) => _selectedSeatIds.contains(seat.id))
        .toList();
  }

  double get _totalPrice {
    return _selectedSeatsObjects.fold(0.0, (sum, seat) => sum + seat.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Koltuk Seçimi',
          style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Appcolor.buttonColor),
      ),
      body: FutureBuilder<SeatResponse>(
        future: _seatResponseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolor.buttonColor),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Appcolor.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bir hata oluştu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Appcolor.white.withOpacity(0.7)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _seatResponseFuture = _loadSeats();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tekrar Dene'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.buttonColor,
                      foregroundColor: Appcolor.appBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.success) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.theater_comedy,
                    size: 60,
                    color: Appcolor.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    snapshot.data?.message ?? 'Koltuk verisi alınamadı',
                    style: TextStyle(color: Appcolor.white.withOpacity(0.7)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final seatDataDetail = snapshot.data!.data.seatData;
          _allSeats =
              seatDataDetail.seats.values.expand((list) => list).toList();

          final sortedRowKeys =
              seatDataDetail.seats.keys.toList()
                ..sort((a, b) => a.compareTo(b));

          return Column(
            children: [
              // Screen section
              _buildScreenSection(),

              // Legend section
              _buildLegendSection(),

              // Seats
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children:
                        sortedRowKeys.map((rowKey) {
                          final seatsInRow = seatDataDetail.seats[rowKey]!;
                          return _buildSeatRow(rowKey, seatsInRow);
                        }).toList(),
                  ),
                ),
              ),

              // Summary section
              _buildSummarySection(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScreenSection() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 60,
        bottom: 20,
      ),
      child: Column(
        children: [
          // Screen visualization
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Appcolor.buttonColor.withOpacity(0.7),
                  Appcolor.buttonColor.withOpacity(0.1),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Appcolor.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.movie,
                  color: Appcolor.buttonColor.withOpacity(0.7),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'PERDE',
                  style: TextStyle(
                    color: Appcolor.white.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.movie,
                  color: Appcolor.buttonColor.withOpacity(0.7),
                  size: 18,
                ),
              ],
            ),
          ),

          // Hall info and direction indicator
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Appcolor.buttonColor.withOpacity(0.7),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'SAHNE TARAFI',
                      style: TextStyle(
                        color: Appcolor.buttonColor.withOpacity(0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Appcolor.darkGrey,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Appcolor.buttonColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'SALON 3',
                    style: TextStyle(
                      color: Appcolor.white.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'İZLEYİCİ',
                      style: TextStyle(
                        color: Appcolor.buttonColor.withOpacity(0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_downward,
                      color: Appcolor.buttonColor.withOpacity(0.7),
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Appcolor.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem('Boş', Appcolor.darkGrey),
          _buildLegendItem('Seçili', Appcolor.buttonColor),
          _buildLegendItem('Dolu', Appcolor.grey),
          _buildLegendItem('VIP', const Color(0xFF8B4513)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: Appcolor.white.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Appcolor.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildSeatRow(String rowKey, List<Seat> seatsInRow) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          // Row label (A, B, C...)
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Appcolor.buttonColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                rowKey,
                style: TextStyle(
                  color: Appcolor.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),

          // Seats
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    seatsInRow.map((seat) {
                      final bool isSelected = _selectedSeatIds.contains(
                        seat.id,
                      );
                      return _buildSeatItem(seat, isSelected);
                    }).toList(),
              ),
            ),
          ),

          // Right side row label (for convenience)
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Appcolor.buttonColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                rowKey,
                style: TextStyle(
                  color: Appcolor.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatItem(Seat seat, bool isSelected) {
    final bool isAvailable =
        seat.status.toLowerCase() == 'available' &&
        seat.type.toLowerCase() != 'disabled';

    return GestureDetector(
      onTap: () => _toggleSeatSelection(seat),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        child: Tooltip(
          message: '${seat.id} - ${seat.type}\nFiyat: ${seat.price} TL',
          child: _buildSeatWidget(seat, isSelected),
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Selected seats
            if (_selectedSeatIds.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Seçilen Koltuklar (${_selectedSeatIds.length})',
                    style: TextStyle(
                      color: Appcolor.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _selectedSeatIds.toList().join(', '),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Appcolor.white,
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Seat types distribution
              if (_selectedSeatsObjects.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Appcolor.buttonColor.withOpacity(0.8),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _getSelectedSeatsSummary(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Appcolor.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),

              Divider(height: 24, color: Appcolor.grey),
            ],

            // Total price and confirmation button
            Row(
              children: [
                // Total price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Toplam Tutar',
                        style: TextStyle(
                          color: Appcolor.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${_totalPrice.toStringAsFixed(2)} TL',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Confirmation button
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        _selectedSeatIds.isEmpty
                            ? null
                            : () {
                              if (_selectedSeatIds.length > 1) {
                                _showMessage(
                                  'Lütfen sadece bir koltuk seçin.',
                                  isError: true,
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => TicketCreatePage(
                                        showtimeId:
                                            widget.showtimeId.toString(),
                                        seatNumber:
                                            _selectedSeatIds
                                                .first, // İlk seçilen koltuğun ID'si
                                      ),
                                ),
                              );
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.buttonColor,
                      foregroundColor: Appcolor.appBackgroundColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      disabledBackgroundColor: Appcolor.grey,
                    ),
                    child: Text(
                      _selectedSeatIds.isEmpty
                          ? 'Koltuk Seçiniz'
                          : 'Seçimi Onayla',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getSelectedSeatsSummary() {
    int standardCount = 0;
    int premiumCount = 0;

    for (final seat in _selectedSeatsObjects) {
      if (seat.type.toLowerCase() == 'premium' ||
          seat.type.toLowerCase() == 'vip') {
        premiumCount++;
      } else {
        standardCount++;
      }
    }

    final List<String> parts = [];
    if (standardCount > 0) {
      parts.add('$standardCount Standart');
    }
    if (premiumCount > 0) {
      parts.add('$premiumCount VIP/Premium');
    }

    return parts.join(', ');
  }
}
