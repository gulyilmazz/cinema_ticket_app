import 'package:cinemaa/models/hall_response.dart';
import 'package:cinemaa/widgets/hall_widgets/hall_card.dart';
import 'package:flutter/material.dart';

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
            Icon(Icons.search_off, size: 70, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Aradığınız kriterlere uygun\nsinema salonu bulunamadı',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Bu şehirde henüz sinema salonu bulunamadı',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
          Icon(Icons.error_outline, size: 60, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text("Yeniden Dene"),
            style: ElevatedButton.styleFrom(
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
