import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/models/ticket_byuser_response.dart';
import 'package:cinemaa/services/ticket/ticket_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/core/storage.dart';
import 'package:intl/intl.dart';

class UserTicketsPage extends StatefulWidget {
  const UserTicketsPage({super.key});

  @override
  State<UserTicketsPage> createState() => _UserTicketsPageState();
}

class _UserTicketsPageState extends State<UserTicketsPage>
    with TickerProviderStateMixin {
  late Future<TicketByUserResponse> _ticketsFuture;
  final TicketsService _ticketsService = TicketsService();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _ticketsFuture = _loadTickets();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<TicketByUserResponse> _loadTickets() async {
    final token = await AuthStorage.getToken();
    final userId = await AuthStorage.getUserId();
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Appcolor.darkGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.movie_filter_outlined,
                  size: 80,
                  color: Appcolor.buttonColor.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Henüz biletiniz yok',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'İlk biletinizi almak için filmleri keşfedin',
                  style: TextStyle(
                    fontSize: 16,
                    color: Appcolor.white.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Appcolor.darkGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Appcolor.buttonColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Biletleriniz yükleniyor...',
                  style: TextStyle(fontSize: 18, color: Appcolor.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Appcolor.darkGrey,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 24),
                const Text(
                  'Biletler yüklenirken hata oluştu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  error,
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _ticketsFuture = _loadTickets();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.buttonColor,
                    foregroundColor: Appcolor.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tekrar Dene',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(ticket, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 0.1 * (index + 1)),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Interval(
                (index * 0.1).clamp(0.0, 1.0),
                ((index * 0.1) + 0.3).clamp(0.0, 1.0),
                curve: Curves.easeOutCubic,
              ),
            ),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  (index * 0.1).clamp(0.0, 1.0),
                  ((index * 0.1) + 0.5).clamp(0.0, 1.0),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Appcolor.darkGrey, Appcolor.grey],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header with status
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                        ticket.status,
                      ).withValues(alpha: 0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.confirmation_number,
                              color: Appcolor.buttonColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              ticket.ticketCode ?? 'Bilet Kodu Yok',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Appcolor.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(ticket.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStatusText(ticket.status),
                            style: const TextStyle(
                              color: Appcolor.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Movie info
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 80,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Appcolor.appBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child:
                                ticket.showtime?.movie?.posterUrl != null
                                    ? Image.network(
                                      ticket.showtime!.movie!.posterUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Icons.movie,
                                            size: 40,
                                            color: Appcolor.buttonColor,
                                          ),
                                    )
                                    : Icon(
                                      Icons.movie,
                                      size: 40,
                                      color: Appcolor.buttonColor,
                                    ),
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
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              _buildInfoChip(
                                Icons.category,
                                ticket.showtime?.movie?.genre ?? 'Bilinmiyor',
                              ),
                              const SizedBox(height: 8),
                              _buildInfoChip(
                                Icons.attach_money,
                                '${ticket.price ?? '0'} TL',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Ticket details
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Appcolor.appBackgroundColor.withValues(alpha: 0.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          Icons.access_time,
                          'Seans',
                          _formatDateTime(ticket.showtime?.startTime),
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          Icons.event_seat,
                          'Koltuk',
                          ticket.seatNumber ?? 'Bilinmiyor',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          Icons.location_on,
                          'Sinema',
                          ticket.showtime?.cinemaHall?.cinema?.name ??
                              'Bilinmiyor',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          Icons.meeting_room,
                          'Salon',
                          '${ticket.showtime?.cinemaHall?.name ?? 'Bilinmiyor'} ${ticket.showtime?.cinemaHall?.type != null ? '(${ticket.showtime?.cinemaHall?.type})' : ''}',
                        ),
                        if (ticket.showtime?.cinemaHall?.cinema?.address !=
                            null) ...[
                          const SizedBox(height: 12),
                          _buildDetailRow(
                            Icons.place,
                            'Adres',
                            ticket.showtime!.cinemaHall!.cinema!.address!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Appcolor.buttonColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Appcolor.buttonColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Appcolor.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Appcolor.buttonColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: Appcolor.buttonColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Appcolor.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Appcolor.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'reserved':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'used':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'reserved':
        return 'REZERVE';
      case 'cancelled':
        return 'İPTAL';
      case 'used':
        return 'KULLANILDI';
      default:
        return 'BİLİNMİYOR';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Appcolor.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Biletlerim',
          style: TextStyle(
            color: Appcolor.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Appcolor.white),
            onPressed: () {
              setState(() {
                _ticketsFuture = _loadTickets();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<TicketByUserResponse>(
        future: _ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          }

          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }

          if (!snapshot.hasData ||
              snapshot.data!.data == null ||
              snapshot.data!.data!.isEmpty) {
            return _buildEmptyState();
          }

          final tickets = snapshot.data!.data!;

          return FadeTransition(
            opacity: _fadeAnimation,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_number,
                          color: Appcolor.buttonColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${tickets.length} Bilet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Appcolor.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return _buildTicketCard(tickets[index], index);
                    }, childCount: tickets.length),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          );
        },
      ),
    );
  }
}
