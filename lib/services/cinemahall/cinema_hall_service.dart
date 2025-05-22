import 'package:cinemaa/models/cinemahall_response.dart';
import 'package:cinemaa/services/client_service.dart';

class CinemaHallService {
  final ApiClient _apiClient;

  CinemaHallService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<CinemahallResponse> getCinemaHall({
    required String token,
    required int sinemaId,
  }) async {
    final response = await _apiClient.get(
      'cinema-halls/hall-by-cinema/$sinemaId',
      token: token,
    );
    return CinemahallResponse.fromJson(response);
  }

  static getCityById(String cityId, {required String token}) {}
}
