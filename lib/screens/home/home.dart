import 'package:cinemaa/core/storage.dart';
import 'package:cinemaa/core/theme/theme.dart';
import 'package:cinemaa/screens/movie/film_detail_screen.dart';
import 'package:cinemaa/services/movies/movie_service.dart';
import 'package:cinemaa/widgets/buttons/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cinemaa/models/movie_response1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final MovieService _movieService = MovieService();
  bool _isLoading = true;
  List<MovieResponse2> _allMovies = [];
  List<MovieResponse2> _filteredMovies = [];
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
      drawer: LeftDrawer(),
      backgroundColor: Appcolor.appBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            if (_categories.length > 1) _buildCategoryTabs(),
            Expanded(
              child:
                  _errorMessage != null ? _buildErrorView() : _buildMovieList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, color: Appcolor.buttonColor),
          ),
          const Text(
            'Cinemaa',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Appcolor.buttonColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Appcolor.buttonColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Appcolor.buttonColor),
              onPressed: _refreshMovies,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSearchVisible = !_isSearchVisible;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Appcolor.darkGrey,
            border: Border.all(color: Appcolor.buttonColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.search, color: Appcolor.buttonColor),
              const SizedBox(width: 12),
              _isSearchVisible
                  ? Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Film ara...',
                        hintStyle: TextStyle(
                          color: Appcolor.white,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Appcolor.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                  : Text(
                    'Film ara...',
                    style: TextStyle(
                      color: Appcolor.white.withValues(alpha: 0.7),
                      fontSize: 16,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Appcolor.buttonColor,
        indicatorWeight: 3,
        labelColor: Appcolor.buttonColor,
        unselectedLabelColor: Appcolor.white.withValues(alpha: 0.7),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        tabs: _categories.map((category) => Tab(text: category)).toList(),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: TextStyle(
              color: Appcolor.white.withValues(alpha: 0.8),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _fetchMovies,
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.buttonColor,
              foregroundColor: Appcolor.appBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Yeniden Dene',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList() {
    return RefreshIndicator(
      onRefresh: _refreshMovies,
      backgroundColor: Appcolor.darkGrey,
      color: Appcolor.buttonColor,
      child:
          _filteredMovies.isEmpty && !_isLoading
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.movie_filter_outlined,
                      size: 80,
                      color: Appcolor.white.withValues(alpha: 0.4),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Henüz film bulunamadı',
                      style: TextStyle(
                        color: Appcolor.white.withValues(alpha: 0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _filteredMovies.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _filteredMovies.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          color: Appcolor.buttonColor,
                        ),
                      ),
                    );
                  }

                  final movie = _filteredMovies[index];
                  return _buildMovieCard(movie);
                },
              ),
    );
  }

  Widget _buildMovieCard(MovieResponse2 movie) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Appcolor.darkGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
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
                                color: Appcolor.grey,
                                child: Icon(
                                  Icons.movie,
                                  size: 50,
                                  color: Appcolor.white.withValues(alpha: 0.3),
                                ),
                              );
                            },
                          ),
                        )
                        : Container(
                          color: Appcolor.grey,
                          child: Icon(
                            Icons.movie,
                            size: 50,
                            color: Appcolor.white.withValues(alpha: 0.3),
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
                        movie.title ?? 'Bilinmeyen Film',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.white,
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
                            const Icon(
                              Icons.star,
                              color: Appcolor.buttonColor,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.imdbRating}/10',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Appcolor.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (movie.duration != null) ...[
                            Icon(
                              Icons.access_time,
                              color: Appcolor.white.withValues(alpha: 0.7),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.duration} dk',
                              style: TextStyle(
                                fontSize: 14,
                                color: Appcolor.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (movie.language != null)
                        Text(
                          movie.language!,
                          style: TextStyle(
                            color: Appcolor.white.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 12),
                      if (movie.isInTheaters == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green, width: 1),
                          ),
                          child: const Text(
                            'Vizyonda',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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
                color: Appcolor.buttonColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Appcolor.buttonColor, width: 1),
              ),
              child: Text(
                genre,
                style: const TextStyle(
                  color: Appcolor.buttonColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
    );
  }
}
