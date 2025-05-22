import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/screens/seans/seans.screen.dart';
import 'package:cinemaa/services/cinemahall/cinema_hall_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/cinemahall_response.dart';

// AppColor theme
class Appcolor {
  static const appBackgroundColor = Color(0xFF1c1c27);
  static const grey = Color(0xFF373741);
  static const buttonColor = Color(0xFFffb43b);
  static const white = Colors.white;
  static const darkGrey = Color(0xFF252532);
}

class CinemaHallsPage extends StatefulWidget {
  const CinemaHallsPage({Key? key}) : super(key: key);

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
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildSearchBar()),
          _buildSliverBody(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Appcolor.appBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Appcolor.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Sinema Salonları',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Appcolor.appBackgroundColor, Appcolor.darkGrey],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Appcolor.buttonColor),
          onPressed: _fetchCinemaHalls,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Appcolor.darkGrey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Appcolor.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Salon ara...',
            hintStyle: TextStyle(color: Appcolor.white.withOpacity(0.6)),
            prefixIcon: const Icon(
              Icons.search,
              color: Appcolor.buttonColor,
              size: 24,
            ),
            suffixIcon:
                _searchController.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Appcolor.buttonColor,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged();
                      },
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
          ),
        ),
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
      return SliverFillRemaining(child: _buildErrorView());
    }

    if (_cinemaHalls.isEmpty) {
      return SliverFillRemaining(child: _buildEmptyView());
    }

    final displayHalls = _isSearching ? _filteredCinemaHalls : _cinemaHalls;

    if (_isSearching && displayHalls.isEmpty) {
      return SliverFillRemaining(child: _buildNoSearchResultsView());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final hall = displayHalls[index];
          return _buildHallCard(hall, index);
        }, childCount: displayHalls.length),
      ),
    );
  }

  Widget _buildHallCard(CinemaResponse hall, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SeansPage(hallId: hall.id ?? 0),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Appcolor.darkGrey, Appcolor.grey.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hall.name ?? 'Bilinmeyen Salon',
                          style: const TextStyle(
                            fontSize: 20,
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
                          color: Appcolor.buttonColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Appcolor.buttonColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          hall.type ?? 'Standard',
                          style: const TextStyle(
                            color: Appcolor.buttonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    Icons.event_seat,
                    'Kapasite: ${hall.capacity ?? 'Bilinmiyor'}',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.update,
                    'Güncelleme: ${_formatDate(hall.updatedAt)}',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Appcolor.buttonColor, Color(0xFFe6a332)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolor.buttonColor.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        SeansPage(hallId: hall.id ?? 0),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Seansları Gör',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Appcolor.buttonColor),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: Appcolor.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _errorMessage!,
              style: const TextStyle(
                fontSize: 16,
                color: Appcolor.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Appcolor.buttonColor, Color(0xFFe6a332)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed: _fetchCinemaHalls,
                icon: const Icon(Icons.refresh, color: Colors.black),
                label: const Text(
                  'Yeniden Dene',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appcolor.darkGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.movie_filter_outlined,
                size: 80,
                color: Appcolor.buttonColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Bu sinemada henüz salon bulunamadı',
              style: TextStyle(
                fontSize: 18,
                color: Appcolor.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSearchResultsView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appcolor.darkGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.search_off,
                size: 70,
                color: Appcolor.buttonColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Aradığınız kriterlere uygun\nsinema salonu bulunamadı',
              style: TextStyle(
                fontSize: 16,
                color: Appcolor.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Bilinmiyor';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Geçersiz tarih';
    }
  }
}
