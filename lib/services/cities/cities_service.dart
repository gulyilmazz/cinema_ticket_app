import 'package:cinemaa/models/cities_response.dart';
import 'package:cinemaa/services/client_service.dart';

class CitiesService {
  final ApiClient _apiClient;

  CitiesService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<CitiesResponse> getCities({required String token}) async {
    final response = await _apiClient.get('cities', token: token);
    return CitiesResponse.fromJson(response);
  }
}
