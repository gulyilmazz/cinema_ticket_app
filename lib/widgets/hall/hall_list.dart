import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../models/hall_response.dart';
import 'hall_card.dart';

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
