import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/models/seats_response.dart';
import 'package:cinemaa/services/seat/seat_service.dart';
import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  final int hallId;

  const SeatSelectionScreen({super.key, required this.hallId});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late Future<SeatResponse> _seatResponseFuture;
  final SeatsService seatsService = SeatsService(); // Servisi başlat

  // Seçili koltukların ID'lerini tutmak için bir Set kullanalım
  final Set<String> _selectedSeatIds = {};
  List<Seat> _allSeats =
      []; // Tüm koltukları burada saklayacağız, fiyat hesaplaması için

  @override
  void initState() {
    super.initState();
    _seatResponseFuture = _loadSeats();
  }

  Future<SeatResponse> _loadSeats() async {
    final token = await AuthStorage.getToken();
    if (token == null) {
      // Token yoksa boş başarılı bir response dönebilirsin
      print("object");
    }
    return seatsService.getSeast(
      hallId: widget.hallId,
      token: token.toString(),
    );
  }

  void _toggleSeatSelection(Seat seat) {
    // Sadece 'available' durumdaki koltuklar seçilebilir olmalı
    // ve 'disabled' tipindeki koltuklar seçilememeli
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            seat.type.toLowerCase() == 'disabled'
                ? 'Bu koltuk engelli koltuğudur ve seçilemez.'
                : 'Bu koltuk (${seat.status}) seçilemez.',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Color _getSeatColor(Seat seat, bool isSelected) {
    if (isSelected) return Colors.orange; // Seçili koltuk

    // API'den gelen 'status' ve 'type' değerlerine göre renk belirle
    switch (seat.status.toLowerCase()) {
      case 'available':
        if (seat.type.toLowerCase() == 'premium') return Colors.purple[300]!;
        if (seat.type.toLowerCase() == 'disabled')
          return Colors.grey[600]!; // Seçilemeyen ama görünen disabled
        return Colors.green[300]!; // Normal uygun koltuk
      case 'booked':
      case 'sold': // veya başka bir dolu statüsü
        return Colors.red[300]!;
      default: // Bilinmeyen durumlar için
        return Colors.grey[400]!;
    }
  }

  IconData _getSeatIcon(Seat seat, bool isSelected) {
    if (seat.type.toLowerCase() == 'disabled') return Icons.accessible_sharp;
    return Icons.event_seat;
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
      appBar: AppBar(title: const Text('Koltuk Seçimi')),
      body: FutureBuilder<SeatResponse>(
        future: _seatResponseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Hata oluştu: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.success) {
            return Center(
              child: Text(snapshot.data?.message ?? 'Koltuk verisi alınamadı.'),
            );
          }

          final seatDataDetail = snapshot.data!.data.seatData;
          // Sıra harflerini sıralı almak için (A, B, C...)
          final sortedRowKeys =
              seatDataDetail.seats.keys.toList()
                ..sort((a, b) => a.compareTo(b));

          return Column(
            children: [
              // Perde Yazısı
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'PERDE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
              ),
              // Koltuklar
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:
                          sortedRowKeys.map((rowKey) {
                            final seatsInRow = seatDataDetail.seats[rowKey]!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Sıra Harfi
                                  SizedBox(
                                    width: 25,
                                    child: Text(
                                      rowKey,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // Sıradaki Koltuklar
                                  Wrap(
                                    // Wrap, koltuklar sığmazsa alt satıra geçmesini sağlar
                                    spacing:
                                        5.0, // Koltuklar arası yatay boşluk
                                    runSpacing:
                                        5.0, // Satırlar arası dikey boşluk
                                    children:
                                        seatsInRow.map((seat) {
                                          final isSelected = _selectedSeatIds
                                              .contains(seat.id);
                                          return GestureDetector(
                                            onTap:
                                                () =>
                                                    _toggleSeatSelection(seat),
                                            child: Tooltip(
                                              message:
                                                  '${seat.id} - ${seat.type} - ${seat.price} TL\nDurum: ${seat.status}',
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: _getSeatColor(
                                                    seat,
                                                    isSelected,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color:
                                                        isSelected
                                                            ? Colors.black
                                                            : Colors.black54,
                                                    width: isSelected ? 2 : 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    _getSeatIcon(
                                                      seat,
                                                      isSelected,
                                                    ),
                                                    size: 20,
                                                    color:
                                                        (seat.status.toLowerCase() !=
                                                                    'available' ||
                                                                seat.type.toLowerCase() ==
                                                                    'disabled')
                                                            ? Colors.white70
                                                            : (isSelected
                                                                ? Colors.white
                                                                : Colors.black87),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              // Seçim Özeti ve Onay Butonu
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_selectedSeatIds.isNotEmpty)
                      Text(
                        'Seçilen Koltuklar: ${_selectedSeatsObjects.map((s) => s?.id).join(', ')}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    if (_selectedSeatIds.isNotEmpty) const SizedBox(height: 8),
                    if (_selectedSeatIds.isNotEmpty)
                      Text(
                        'Toplam Fiyat: ${_totalPrice.toStringAsFixed(2)} TL',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          _selectedSeatIds.isEmpty
                              ? null // Hiç koltuk seçilmediyse buton pasif
                              : () {
                                // Onaylama işlemi
                                debugPrint(
                                  'Seçilen Koltuk IDleri: $_selectedSeatIds',
                                );
                                debugPrint(
                                  'Seçilen Koltuk Objeleri: ${_selectedSeatsObjects.map((s) => s.id).toList()}',
                                );
                                debugPrint('Toplam Fiyat: $_totalPrice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${_selectedSeatIds.length} koltuk seçildi. Toplam: $_totalPrice TL',
                                    ),
                                  ),
                                );
                                // Burada ödeme sayfasına yönlendirme vs. yapılabilir.
                              },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Seçimi Onayla',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
