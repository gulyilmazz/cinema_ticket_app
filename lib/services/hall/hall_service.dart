import 'package:cinemaa/models/hall_response.dart';
import 'package:cinemaa/services/client_service.dart';

class HallService {
  final ApiClient _apiClient;

  HallService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<SalonResponse> getHallsByCity({
    required int cityId,
    required String token,
  }) async {
    final response = await _apiClient.get(
      'cinemas/cinema-by-city/$cityId',
      token: token,
    );
    return SalonResponse.fromJson(response);
  }

  static getCityById(String cityId, {required String token}) {}
}
