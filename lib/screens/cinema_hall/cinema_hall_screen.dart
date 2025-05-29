import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/services/cinemahall/cinema_hall_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/cinemahall_response.dart';

// Widget imports
import 'package:cinemaa/widgets/cinema_hall/cinema_hall_app_bar.dart';
import 'package:cinemaa/widgets/cinema_hall/cinema_hall_search_bar.dart';
import 'package:cinemaa/widgets/cinema_hall/cinema_hall_card.dart';
import 'package:cinemaa/widgets/cinema_hall/cinema_hall_error_view.dart';
import 'package:cinemaa/widgets/cinema_hall/cinema_hall_empty_view.dart';
import 'package:cinemaa/widgets/cinema_hall/cinema_hall_no_search_results.dart';

class CinemaHallsPage extends StatefulWidget {
  const CinemaHallsPage({super.key});

  @override
  State<CinemaHallsPage> createState() => _CinemaHallsPageState();
}

class _CinemaHallsPageState extends State<CinemaHallsPage> {
  final CinemaHallService _cinemaHallService = CinemaHallService();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  List<CinemaResponse> _cinemaHalls = [];
  List<CinemaResponse> _filteredCinemaHalls = [];
  String? _errorMessage;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchCinemaHalls();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (_isSearching) {
        _filteredCinemaHalls =
            _cinemaHalls.where((hall) {
              return (hall.name?.toLowerCase().contains(query) ?? false) ||
                  (hall.type?.toLowerCase().contains(query) ?? false);
            }).toList();
      }
    });
  }

  void _onSearchClear() {
    _searchController.clear();
    _onSearchChanged();
  }

  Future<void> _fetchCinemaHalls() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await AuthStorage.getToken();
      final cinemaId = await AuthStorage.getCinemaId();

      if (token == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      final response = await _cinemaHallService.getCinemaHall(
        token: token,
        sinemaId: int.tryParse(cinemaId!)!,
      );

      if (response.success == true) {
        setState(() {
          _cinemaHalls = response.data ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = response.message ?? 'Sinema salonları yüklenemedi';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Bir hata oluştu: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CinemaHallAppBar(onRefresh: _fetchCinemaHalls),
          SliverToBoxAdapter(
            child: CinemaHallSearchBar(
              controller: _searchController,
              onClear: _onSearchClear,
            ),
          ),
          _buildSliverBody(),
        ],
      ),
    );
  }

  Widget _buildSliverBody() {
    if (_isLoading) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Appcolor.buttonColor),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return SliverFillRemaining(
        child: CinemaHallErrorView(
          errorMessage: _errorMessage!,
          onRetry: _fetchCinemaHalls,
        ),
      );
    }

    if (_cinemaHalls.isEmpty) {
      return const SliverFillRemaining(child: CinemaHallEmptyView());
    }

    final displayHalls = _isSearching ? _filteredCinemaHalls : _cinemaHalls;

    if (_isSearching && displayHalls.isEmpty) {
      return const SliverFillRemaining(child: CinemaHallNoSearchResults());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final hall = displayHalls[index];
          return CinemaHallCard(hall: hall);
        }, childCount: displayHalls.length),
      ),
    );
  }
}
