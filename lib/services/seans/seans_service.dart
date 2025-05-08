import 'package:cinemaa/models/seans_response.dart';
import 'package:cinemaa/services/client_service.dart';

class SeansService {
  final ApiClient _apiClient;

  SeansService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<SeansListResponse> getSeanslar({
    required String token,
    required int hallId,
  }) async {
    final response = await _apiClient.get(
      'showtimes/showtime-by-hall/$hallId',
      token: token,
    );
    return SeansListResponse.fromJson(response);
  }
}
