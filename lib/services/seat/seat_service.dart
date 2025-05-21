import 'package:cinemaa/models/seats_response.dart';
import 'package:cinemaa/services/client_service.dart';

class SeatsService {
  final ApiClient _apiClient;

  SeatsService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<SeatResponse> getSeast({
    required String token,
    required int hallId,
  }) async {
    final response = await _apiClient.get(
      'seats/seat-by-hall/$hallId',
      token: token,
    );
    return SeatResponse.fromJson(response);
  }
}
