import 'dart:developer';

import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/models/cities_response.dart';
import 'package:cinemaa/screens/hall/hall_screen.dart';
import 'package:cinemaa/services/cities/cities_service.dart';
import 'package:cinemaa/widgets/cities/cities_app_bar.dart';
import 'package:cinemaa/widgets/cities/cities_loading_state.dart';
import 'package:cinemaa/widgets/cities/cities_error_state.dart';
import 'package:cinemaa/widgets/cities/cities_empty_state.dart';
import 'package:cinemaa/widgets/cities/cities_no_search_results.dart';
import 'package:cinemaa/widgets/cities/cities_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitiesScreen extends StatefulWidget {
  const CitiesScreen({super.key});

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen>
    with SingleTickerProviderStateMixin {
  final CitiesService _citiesService = CitiesService();
  bool _isLoading = true;
  List<City> _cities = [];
  String? _error;
  late AnimationController _animationController;
  final TextEditingController _searchController = TextEditingController();
  List<City> _filteredCities = [];
  bool _isSearching = false;

  void _onCitySelected(City city) async {
    HapticFeedback.mediumImpact();

    await AuthStorage.saveCitiesId(city.id.toString());
    log('Seçilen şehir ID: ${city.id}');

    _animationController.forward().then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HallScreen()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fetchCities();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterCities(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredCities = _cities;
      } else {
        _filteredCities =
            _cities
                .where(
                  (city) =>
                      city.name?.toLowerCase().contains(query.toLowerCase()) ??
                      false,
                )
                .toList();
      }
    });
  }

  Future<void> _fetchCities() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final token = await AuthStorage.getToken();

      if (token == null) {
        if (mounted) {
          setState(() {
            _error =
                'Oturum süresi dolmuş olabilir. Lütfen tekrar giriş yapın.';
            _isLoading = false;
          });
        }
        return;
      }

      final response = await _citiesService.getCities(token: token);

      if (mounted) {
        setState(() {
          _cities = response.data ?? [];
          _filteredCities = _cities;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Şehirleri çekerken hata oluştu: $e');
      if (mounted) {
        setState(() {
          _error =
              'Bağlantı hatası. Lütfen internet bağlantınızı kontrol edin.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            children: [
              CitiesAppBar(
                searchController: _searchController,
                onSearchChanged: _filterCities,
                onBackPressed: () => Navigator.pop(context),
              ),
              if (_isLoading)
                const CitiesLoadingState()
              else if (_error != null)
                CitiesErrorState(error: _error!, onRetry: _fetchCities)
              else if (_filteredCities.isEmpty && _isSearching)
                CitiesNoSearchResults(searchQuery: _searchController.text)
              else if (_cities.isEmpty)
                const CitiesEmptyState()
              else
                CitiesList(
                  cities: _filteredCities,
                  onCitySelected: _onCitySelected,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
