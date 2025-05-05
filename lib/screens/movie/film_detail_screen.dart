import 'package:cinemaa/core/storage.dart';
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
  Data? _movie;
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
          orElse: () => Data(),
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
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 152, 147, 196),
              const Color.fromARGB(255, 211, 208, 218),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
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
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
                : _buildMovieDetails(),
      ),
    );
  }

  Widget _buildMovieDetails() {
    if (_movie == null) {
      return const Center(child: Text('Movie data is not available'));
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: const Color.fromARGB(255, 9, 14, 10),
          iconTheme: IconThemeData(
            color: const Color.fromARGB(255, 10, 223, 230),
          ),
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
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.movie,
                            size: 100,
                            color: Colors.grey.shade700,
                          ),
                        );
                      },
                    )
                    : Container(
                      color: Colors.grey.shade300,
                      child: Icon(
                        Icons.movie,
                        size: 100,
                        color: Colors.grey.shade700,
                      ),
                    ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                if (_movie!.imdbRating != null) ...[
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${_movie!.imdbRating}/10',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                                SizedBox(width: 8),
                                if (_movie!.genre != null)
                                  Text(
                                    _movie!.genre!,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Favori butonu
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
                              duration: Duration(seconds: 1),
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
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
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

                SizedBox(height: 16),

                // Synopsis
                Text(
                  'Film Açıklaması',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  _movie!.description ?? 'No description available',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),

                SizedBox(height: 24),

                // Book Tickets Button
                InkWell(
                  onTap: () {
                    // Add functionality to book tickets
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 9, 14, 10),
                          const Color.fromARGB(255, 118, 113, 167),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color.fromARGB(255, 10, 222, 230),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Book Tickets',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                if (_movie!.isInTheaters == true) ...[
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Currently In Theaters',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
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
