import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/screens/cinema_hall/cinema_hall_screen.dart';
import 'package:cinemaa/services/movies/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/movie_response1.dart';
import 'package:intl/intl.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieService _movieService = MovieService();
  bool _isLoading = true;
  MovieResponse2? _movie;
  String? _errorMessage;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await AuthStorage.getToken();

      if (token == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage =
                'Authentication token not found. Please login again.';
          });
        }
        return;
      }

      final response = await _movieService.getMovies(token: token);

      if (response.success == true &&
          response.data != null &&
          response.data!.data != null) {
        // Find movie by ID in the list
        final movieData = response.data!.data!.firstWhere(
          (movie) => movie.id == widget.movieId,
          orElse: () => MovieResponse2(),
        );

        if (movieData.id != null) {
          setState(() {
            _movie = movieData;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Movie not found';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Failed to load movie details';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0) {
      return '${hours}h ${remainingMinutes}m';
    } else {
      return '${remainingMinutes}m';
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMMM d, y').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Appcolor.buttonColor,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: Appcolor.white))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Appcolor.buttonColor),
              )
              : _errorMessage != null
              ? Center(
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
                      onPressed: _fetchMovieDetails,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.buttonColor,
                        foregroundColor: Appcolor.appBackgroundColor,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
              : _buildMovieDetails(),
    );
  }

  Widget _buildMovieDetails() {
    if (_movie == null) {
      return const Center(
        child: Text(
          'Movie data is not available',
          style: TextStyle(color: Appcolor.white),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: Appcolor.darkGrey,
          iconTheme: const IconThemeData(color: Appcolor.buttonColor),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                _movie!.posterUrl != null
                    ? Image.network(
                      _movie!.posterUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Appcolor.grey,
                          child: const Icon(
                            Icons.movie,
                            size: 100,
                            color: Appcolor.white,
                          ),
                        );
                      },
                    )
                    : Container(
                      color: Appcolor.grey,
                      child: const Icon(
                        Icons.movie,
                        size: 100,
                        color: Appcolor.white,
                      ),
                    ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Appcolor.appBackgroundColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _movie!.title ?? 'Unknown Title',
                              style: const TextStyle(
                                color: Appcolor.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                if (_movie!.imdbRating != null) ...[
                                  const Icon(
                                    Icons.star,
                                    color: Appcolor.buttonColor,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_movie!.imdbRating}/10',
                                    style: const TextStyle(
                                      color: Appcolor.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                                const SizedBox(width: 8),
                                if (_movie!.genre != null)
                                  Text(
                                    _movie!.genre!,
                                    style: TextStyle(
                                      color: Appcolor.white.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Favorite button
                      IconButton(
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isFavorite
                                    ? '${_movie!.title} favorilere eklendi'
                                    : '${_movie!.title} favorilerden çıkarıldı',
                              ),
                              backgroundColor: Appcolor.darkGrey,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Info Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Appcolor.darkGrey,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_movie!.language != null)
                        _buildInfoRow('Language', _movie!.language!),
                      if (_movie!.duration != null)
                        _buildInfoRow(
                          'Duration',
                          _formatDuration(_movie!.duration!),
                        ),
                      if (_movie!.releaseDate != null)
                        _buildInfoRow(
                          'Release Date',
                          _formatDate(_movie!.releaseDate!),
                        ),
                      if (_movie!.imdbId != null)
                        _buildInfoRow('IMDb ID', _movie!.imdbId!),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Synopsis
                const Text(
                  'Film Açıklaması',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Appcolor.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _movie!.description ?? 'No description available',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Appcolor.white.withOpacity(0.9),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Book Tickets Button
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CinemaHallsPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Appcolor.buttonColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolor.buttonColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Bilet Al',
                        style: TextStyle(
                          color: Appcolor.appBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                if (_movie!.isInTheaters == true) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.buttonColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Currently In Theaters',
                      style: TextStyle(
                        color: Appcolor.appBackgroundColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
