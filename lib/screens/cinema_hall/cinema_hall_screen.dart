import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/screens/seans/seans.screen.dart';
import 'package:cinemaa/services/cinemahall/cinema_hall_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/cinemahall_response.dart';

class CinemaHallsPage extends StatefulWidget {
  const CinemaHallsPage({Key? key}) : super(key: key);

  @override
  State<CinemaHallsPage> createState() => _CinemaHallsPageState();
}

class _CinemaHallsPageState extends State<CinemaHallsPage> {
  final CinemaHallService _cinemaHallService = CinemaHallService();
  bool _isLoading = true;
  List<CinemaResponse> _cinemaHalls = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCinemaHalls();
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
          _errorMessage = response.message ?? 'Failed to fetch cinema halls';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Halls'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchCinemaHalls,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
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
              onPressed: _fetchCinemaHalls,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_cinemaHalls.isEmpty) {
      return const Center(child: Text('No cinema halls found for this cinema'));
    }

    return RefreshIndicator(
      onRefresh: _fetchCinemaHalls,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _cinemaHalls.length,
        itemBuilder: (context, index) {
          final hall = _cinemaHalls[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            child: InkWell(
              onTap: () {
                // Navigate to sessions page for this hall
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => SeansPage(
                          hallId: hall.id ?? 0,
                          // Pass the hall ID to the SeansPage
                        ),
                  ),
                );
              },
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
                            hall.name ?? 'Unknown Hall',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hall.type ?? 'Standard',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.event_seat,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Capacity: ${hall.capacity ?? 'Unknown'}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.update, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          'Updated: ${_formatDate(hall.updatedAt)}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }
}
