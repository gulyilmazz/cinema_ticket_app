import 'package:cinemaa/models/movie_response1.dart';
import 'package:cinemaa/services/client_service.dart';

class MovieService {
  final ApiClient _apiClient;

  MovieService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<MoviesResponse> getMovies({required String token}) async {
    final response = await _apiClient.get('movies/movie-list', token: token);
    return MoviesResponse.fromJson(response);
  }
}
