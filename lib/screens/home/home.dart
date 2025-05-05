import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/screens/movie/film_detail_screen.dart';
import 'package:cinemaa/services/movies/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/movie_response1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final MovieService _movieService = MovieService();
  bool _isLoading = true;
  List<Data> _allMovies = [];
  List<Data> _filteredMovies = [];
  String? _errorMessage;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  // Category management
  List<String> _categories = ['All'];
  String _selectedCategory = 'All';

  final ScrollController _scrollController = ScrollController();

  // App theme
  final LinearGradient appGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF090E0A), Color(0xFF55517C)],
  );

  final Color accentColor = const Color(0xFF0ADEE6);

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _searchController.addListener(_onSearchChanged);

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_currentPage < _totalPages) {
          _fetchNextPage();
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterMovies(_selectedCategory, _searchController.text);
  }

  void _filterMovies(String category, String searchQuery) {
    setState(() {
      if (category == 'All' && searchQuery.isEmpty) {
        _filteredMovies = List.from(_allMovies);
      } else {
        _filteredMovies =
            _allMovies.where((movie) {
              bool matchesCategory = category == 'All';

              // Eğer film genre bilgisi varsa, tüm kategoriler içerisinde aranan kategori var mı kontrol et
              if (movie.genre != null && movie.genre!.isNotEmpty) {
                // Her kategorinin tek tek kontrol edilmesi
                List<String> movieGenres = _extractIndividualGenres(
                  movie.genre!,
                );
                matchesCategory =
                    category == 'All' || movieGenres.contains(category);
              }

              bool matchesSearch =
                  searchQuery.isEmpty ||
                  (movie.title?.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ) ??
                      false);
              return matchesCategory && matchesSearch;
            }).toList();
      }
    });
  }

  // Film genrelerini tek tek kategorilere ayıran yardımcı fonksiyon
  List<String> _extractIndividualGenres(String genreString) {
    // Varsayılan olarak virgülle ayrılmış olduğunu kabul edelim
    return genreString.split(',').map((e) => e.trim()).toList();
  }

  Future<void> _fetchMovies() async {
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

      if (response.success == true && response.data != null) {
        // Tüm film kategorilerini topla
        final Set<String> uniqueGenres = {'All'};

        for (var movie in response.data!.data ?? []) {
          if (movie.genre != null && movie.genre!.isNotEmpty) {
            // Genre'leri ayrı ayrı parçalara ayırıp ekle
            List<String> genres = _extractIndividualGenres(movie.genre!);
            uniqueGenres.addAll(genres);
          }
        }

        setState(() {
          _allMovies = response.data!.data ?? [];
          _filteredMovies = List.from(_allMovies);
          _currentPage = response.data!.currentPage ?? 1;
          _totalPages = response.data!.lastPage ?? 1;
          _isLoading = false;
          _categories = uniqueGenres.toList();

          // Initialize tab controller after categories are loaded
          _tabController = TabController(
            length: _categories.length,
            vsync: this,
          );
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                _selectedCategory = _categories[_tabController.index];
                _filterMovies(_selectedCategory, _searchController.text);
              });
            }
          });
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Failed to load movies';
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

  Future<void> _fetchNextPage() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final token = await AuthStorage.getToken();

      if (token == null) {
        setState(() {
          _errorMessage = 'Authentication token not found. Please login again.';
          _isLoading = false;
        });
        return;
      }

      // Your API service should be updated to accept a page parameter
      final response = await _movieService.getMovies(token: token);

      if (response.success == true && response.data != null) {
        final newMovies = response.data!.data ?? [];

        setState(() {
          _allMovies.addAll(newMovies);
          _filterMovies(_selectedCategory, _searchController.text);
          _currentPage = response.data!.currentPage ?? _currentPage + 1;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Failed to load more movies';
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

  Future<void> _refreshMovies() async {
    setState(() {
      _allMovies = [];
      _filteredMovies = [];
      _currentPage = 1;
    });
    await _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildSearchBar(),
              if (_categories.length > 1) _buildCategoryTabs(),

              Expanded(
                child:
                    _errorMessage != null
                        ? _buildErrorView()
                        : _buildMovieList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cinemaa',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: accentColor),
            onPressed: _refreshMovies,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSearchVisible = !_isSearchVisible;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accentColor, width: 1),
            color: Colors.black26,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(Icons.search, color: accentColor),
              const SizedBox(width: 12),
              _isSearchVisible
                  ? Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search movies...',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                  : const Text(
                    'Search movies',
                    style: TextStyle(color: Colors.white70),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return _tabController != null
        ? Container(
          height: 50,
          margin: const EdgeInsets.only(top: 8),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: accentColor,
            indicatorWeight: 3,
            labelColor: accentColor,
            unselectedLabelColor: Colors.white70,
            tabs: _categories.map((category) => Tab(text: category)).toList(),
          ),
        )
        : const SizedBox.shrink();
  }

  Widget _buildErrorView() {
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
            onPressed: _fetchMovies,
            style: ElevatedButton.styleFrom(backgroundColor: accentColor),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList() {
    return RefreshIndicator(
      onRefresh: _refreshMovies,
      color: accentColor,
      child:
          _filteredMovies.isEmpty && !_isLoading
              ? const Center(
                child: Text(
                  'No movies available',
                  style: TextStyle(color: Colors.white70),
                ),
              )
              : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: _filteredMovies.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _filteredMovies.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final movie = _filteredMovies[index];
                  return _buildMovieCard(movie);
                },
              ),
    );
  }

  Widget _buildMovieCard(Data movie) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.8),
            const Color(0xFF333355).withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movieId: movie.id!),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie poster
              SizedBox(
                width: 130,
                height: 200,
                child:
                    movie.posterUrl != null
                        ? Hero(
                          tag: 'movie-${movie.id}',
                          child: Image.network(
                            movie.posterUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade800,
                                child: const Center(
                                  child: Icon(
                                    Icons.movie,
                                    size: 50,
                                    color: Colors.white30,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        : Container(
                          color: Colors.grey.shade800,
                          child: const Center(
                            child: Icon(
                              Icons.movie,
                              size: 50,
                              color: Colors.white30,
                            ),
                          ),
                        ),
              ),
              // Movie details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title ?? 'Unknown Title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      if (movie.genre != null) _buildGenreTags(movie.genre!),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          if (movie.imdbRating != null) ...[
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.imdbRating}/10',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (movie.duration != null) ...[
                            const Icon(
                              Icons.access_time,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.duration} min',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (movie.language != null)
                        Text(
                          movie.language!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 12),
                      if (movie.isInTheaters == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green, width: 1),
                          ),
                          child: const Text(
                            'In Theaters',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Film kategorilerini ayrı etiketler halinde gösteren widget
  Widget _buildGenreTags(String genreString) {
    List<String> genres = _extractIndividualGenres(genreString);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          genres.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentColor, width: 1),
              ),
              child: Text(
                genre,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
    );
  }
}
