import 'dart:developer';

import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/models/hall_response.dart';
import 'package:cinemaa/screens/main_screen.dart';
import 'package:cinemaa/services/hall/hall_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/theme.dart';

class CinemaScreen extends StatefulWidget {
  const CinemaScreen({super.key});

  @override
  State<CinemaScreen> createState() => _CinemaHallScreenState();
}

class _CinemaHallScreenState extends State<CinemaScreen>
    with TickerProviderStateMixin {
  final HallService _hallService = HallService();
  final TextEditingController _searchController = TextEditingController();

  late AnimationController _animationController;
  late AnimationController _refreshAnimationController;

  bool _isLoading = true;
  List<CinemaHall> _cinemaHalls = [];
  List<CinemaHall> _filteredCinemaHalls = [];
  String? _error;
  bool _isSearching = false;
  String _cityName = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _refreshAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fetchCinemaHall();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _refreshAnimationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterCinemas(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredCinemaHalls = _cinemaHalls;
      } else {
        _filteredCinemaHalls =
            _cinemaHalls
                .where(
                  (e) =>
                      e.name?.toLowerCase().contains(query.toLowerCase()) ??
                      false,
                )
                .toList();
      }
    });
  }

  Future<void> _fetchCinemaHall() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final token = await AuthStorage.getToken();
      final citiesId = await AuthStorage.getCitiesId();

      if (citiesId == null) {
        if (mounted) {
          setState(() {
            _error = 'Şehir bilgisi bulunamadı. Lütfen bir şehir seçin.';
            _isLoading = false;
          });
        }
        return;
      }

      if (token == null) {
        if (mounted) {
          setState(() {
            _error = 'Oturum süresi dolmuş. Lütfen tekrar giriş yapın.';
            _isLoading = false;
          });
        }
        return;
      }

      final response = await _hallService.getHallsByCity(
        cityId: int.tryParse(citiesId)!,
        token: token,
      );

      if (mounted) {
        setState(() {
          _cinemaHalls = response.data ?? [];
          _cityName = response.data?.first.city?.name ?? 'Şehir Bilgisi Yok';
          _filteredCinemaHalls = _cinemaHalls;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Sinema salonlarını çekerken hata oluştu: $e');
      if (mounted) {
        setState(() {
          if (e.toString().contains('SocketException') ||
              e.toString().contains('Connection refused')) {
            _error = 'Bağlantı hatası. İnternet bağlantınızı kontrol edin.';
          } else if (e.toString().contains('Unauthorized') ||
              e.toString().contains('401')) {
            _error = 'Oturum süreniz dolmuş. Lütfen tekrar giriş yapın.';
          } else {
            _error = 'Bir hata oluştu: ${e.toString().split(":").first}';
          }
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshData() async {
    _refreshAnimationController.repeat();
    await _fetchCinemaHall();
    _refreshAnimationController.stop();
    _refreshAnimationController.reset();
  }

  void _onCinemaSelected(CinemaHall cinema) async {
    HapticFeedback.selectionClick();
    await AuthStorage.saveCinemaId(cinema.id.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      appBar: HallAppBar(cityName: _cityName),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        backgroundColor: Appcolor.darkGrey,
        color: Appcolor.buttonColor,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Appcolor.buttonColor),
      );
    }

    if (_error != null) {
      return ErrorView(errorMessage: _error!, onRetry: _refreshData);
    }

    if (_cinemaHalls.isEmpty) {
      return const EmptyCinemaView();
    }

    return Column(
      children: [
        HallSearchBar(controller: _searchController, onChanged: _filterCinemas),
        Expanded(
          child: HallList(
            cinemaHalls: _cinemaHalls,
            isSearching: _isSearching,
            filteredCinemaHalls: _filteredCinemaHalls,
            onCinemaSelected: _onCinemaSelected,
          ),
        ),
      ],
    );
  }
}

class HallAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String cityName;

  const HallAppBar({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Appcolor.darkGrey,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Appcolor.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Sinema Salonları',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Appcolor.white,
          fontSize: 18,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Appcolor.buttonColor,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                cityName,
                style: const TextStyle(
                  color: Appcolor.buttonColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HallSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const HallSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Appcolor.darkGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 16, color: Appcolor.white),
          decoration: InputDecoration(
            hintText: 'Sinema salonu ara...',
            hintStyle: TextStyle(color: Appcolor.white.withValues(alpha: 0.6)),
            prefixIcon: const Icon(Icons.search, color: Appcolor.buttonColor),
            suffixIcon:
                controller.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear, color: Appcolor.white),
                      onPressed: () {
                        controller.clear();
                        onChanged('');
                      },
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}

class HallList extends StatelessWidget {
  final List<CinemaHall> cinemaHalls;
  final bool isSearching;
  final List<CinemaHall> filteredCinemaHalls;
  final Function(CinemaHall) onCinemaSelected;

  const HallList({
    super.key,
    required this.cinemaHalls,
    required this.isSearching,
    required this.filteredCinemaHalls,
    required this.onCinemaSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearching && filteredCinemaHalls.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 70,
              color: Appcolor.white.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Aradığınız kriterlere uygun\nsinema salonu bulunamadı',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Appcolor.white.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: isSearching ? filteredCinemaHalls.length : cinemaHalls.length,
      itemBuilder: (context, index) {
        final cinemaHall =
            isSearching ? filteredCinemaHalls[index] : cinemaHalls[index];
        return HallCard(cinema: cinemaHall, onCinemaSelected: onCinemaSelected);
      },
    );
  }
}

class HallCard extends StatelessWidget {
  final CinemaHall cinema;
  final Function(CinemaHall) onCinemaSelected;

  const HallCard({
    super.key,
    required this.cinema,
    required this.onCinemaSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => onCinemaSelected(cinema),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Appcolor.darkGrey,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cinema.name ?? 'İsimsiz Sinema',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Appcolor.buttonColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.event_seat,
                                size: 16,
                                color: Appcolor.buttonColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${cinema.totalCapacity ?? 0} koltuk',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.buttonColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (cinema.address != null && cinema.address!.isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Appcolor.white.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              cinema.address!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Appcolor.white.withValues(alpha: 0.6),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    if (cinema.phone != null && cinema.phone!.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: Appcolor.white.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cinema.phone!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Appcolor.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    if (cinema.description != null &&
                        cinema.description!.isNotEmpty)
                      Text(
                        cinema.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Appcolor.white.withValues(alpha: 0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => onCinemaSelected(cinema),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.buttonColor,
                            foregroundColor: Appcolor.appBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Filmleri Gör',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyCinemaView extends StatelessWidget {
  const EmptyCinemaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_filter_outlined,
            size: 80,
            color: Appcolor.white.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'Bu şehirde henüz sinema salonu bulunamadı',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Appcolor.white.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Appcolor.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text("Yeniden Dene"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.buttonColor,
              foregroundColor: Appcolor.appBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
