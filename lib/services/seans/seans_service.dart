import 'package:cinemaa/models/seans_response.dart';
import 'package:cinemaa/services/client_service.dart';

class SeansService {
  final ApiClient _apiClient;

  SeansService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<seansResponse> getSeanslar({required String token}) async {
    final response = await _apiClient.get(
      'showtimes/showtime-by-hall/2',
      token: token,
    );
    return seansResponse.fromJson(response);
  }

  Future<seansResponse> getSeanslarByHall({
    required int hallId,
    required String token,
  }) async {
    final response = await _apiClient.get(
      'showtimes/showtime-by-hall/2$hallId',
      token: token,
    );
    return seansResponse.fromJson(response);
  }
}
