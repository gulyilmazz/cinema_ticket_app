import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../models/hall_response.dart';

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
