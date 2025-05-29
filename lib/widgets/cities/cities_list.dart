import 'package:cinemaa/models/cities_response.dart';
import 'package:cinemaa/widgets/cities/cities_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CitiesList extends StatelessWidget {
  final List<City> cities;
  final Function(City) onCitySelected;

  const CitiesList({
    super.key,
    required this.cities,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(),
            overscroll: false,
          ),
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 24,
                left: 16,
                right: 16,
              ),
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: CityListItem(
                        city: city,
                        onTap: () => onCitySelected(city),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
