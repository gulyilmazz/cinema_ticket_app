import 'package:cinemaa/models/ticket_byuser_response.dart';
import 'package:cinemaa/services/ticket/ticket_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/core/storage.dart';
import 'package:intl/intl.dart';

class UserTicketsPage extends StatefulWidget {
  const UserTicketsPage({Key? key}) : super(key: key);

  @override
  _UserTicketsPageState createState() => _UserTicketsPageState();
}

class _UserTicketsPageState extends State<UserTicketsPage> {
  late Future<TicketByUserResponse> _ticketsFuture;
  final TicketsService _ticketsService = TicketsService();
  final Color _darkBlue = const Color(0xFF1A2C38);
  final Color _lightBlue = const Color(0xFF3E78B2);
  final Color _gold = const Color(0xFFBFA065);

  @override
  void initState() {
    super.initState();
    _ticketsFuture = _loadTickets();
  }

  Future<TicketByUserResponse> _loadTickets() async {
    final token = await AuthStorage.getToken();
    final userId = await AuthStorage.getUserId(); // Varsayımsal metod
    if (token == null || userId == null) {
      throw Exception('Kullanıcı girişi yapılmamış.');
    }
    return _ticketsService.getTicketsByUser(token: token, userId: userId);
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return 'Bilinmiyor';
    final date = DateTime.parse(dateTime).toLocal();
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biletlerim'),
        backgroundColor: _darkBlue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<TicketByUserResponse>(
        future: _ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Biletler yüklenirken hata oluştu.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _ticketsFuture = _loadTickets();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _lightBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.data == null) {
            return const Center(
              child: Text(
                'Bilet bulunamadı.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final tickets = snapshot.data!.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Film Adı ve Poster
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                ticket.showtime?.movie?.posterUrl != null
                                    ? Image.network(
                                      ticket.showtime!.movie!.posterUrl!,
                                      width: 60,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.movie,
                                                size: 60,
                                                color: Colors.grey,
                                              ),
                                    )
                                    : const Icon(
                                      Icons.movie,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ticket.showtime?.movie?.title ??
                                      'Bilinmeyen Film',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _darkBlue,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tür: ${ticket.showtime?.movie?.genre ?? 'Bilinmiyor'}',
                                  style: TextStyle(
                                    color: _darkBlue.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Seans ve Koltuk Bilgisi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seans: ${_formatDateTime(ticket.showtime?.startTime)}',
                                style: TextStyle(color: _darkBlue),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Koltuk: ${ticket.seatNumber}',
                                style: TextStyle(color: _darkBlue),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Bilet Kodu: ${ticket.ticketCode}',
                                style: TextStyle(
                                  color: _gold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Fiyat: ${ticket.price} TL',
                                style: TextStyle(color: _darkBlue),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Sinema Bilgisi
                      Text(
                        'Sinema: ${ticket.showtime?.cinemaHall?.cinema?.name ?? 'Bilinmiyor'}',
                        style: TextStyle(color: _darkBlue),
                      ),
                      Text(
                        'Salon: ${ticket.showtime?.cinemaHall?.name ?? 'Bilinmiyor'} (${ticket.showtime?.cinemaHall?.type ?? ''})',
                        style: TextStyle(color: _darkBlue.withOpacity(0.7)),
                      ),
                      Text(
                        'Adres: ${ticket.showtime?.cinemaHall?.cinema?.address ?? 'Bilinmiyor'}',
                        style: TextStyle(color: _darkBlue.withOpacity(0.7)),
                      ),

                      // Bilet Durumu
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              ticket.status == 'reserved'
                                  ? _lightBlue
                                  : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Durum: ${ticket.status?.toUpperCase() ?? 'Bilinmiyor'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
