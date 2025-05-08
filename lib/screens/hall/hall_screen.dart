import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/models/hall_response.dart';
import 'package:cinemaa/screens/main_screen.dart';
import 'package:cinemaa/services/hall/hall_service.dart';
import 'package:cinemaa/widgets/hall_widgets/hall_appbar.dart';
import 'package:cinemaa/widgets/hall_widgets/hall_list.dart';
import 'package:cinemaa/widgets/hall_widgets/hall_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      // ignore: avoid_print
      print('Sinema salonlarını çekerken hata oluştu: $e');
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

    // Save selected cinema hall ID
    // AuthStorage.saveHallId(cinema.id.toString()).then((_) {
    //   // Navigate to next screen
    //   _animationController.forward().then((_) {
    //     // Replace with your navigation
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F7),
      appBar: HallAppBar(cityName: _cityName),
      body: RefreshIndicator(onRefresh: _refreshData, child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
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
