import 'package:cinemaa/models/seans_response.dart';
import 'package:cinemaa/services/client_service.dart';

class SeatsService {
  final ApiClient _apiClient;

  SeatsService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<SeansResponse> getSeast({
    required String token,
    required int hallId,
  }) async {
    final response = await _apiClient.get(
      'showtime-by-hall/$hallId',
      token: token,
    );
    return SeansResponse.fromJson(response);
  }
}
