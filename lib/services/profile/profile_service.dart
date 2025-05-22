import 'package:cinemaa/models/profile_response.dart';
import 'package:cinemaa/services/client_service.dart';

class ProfileService {
  final ApiClient _apiClient;

  ProfileService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<ProfileResponse> getProfile({required String token}) async {
    final response = await _apiClient.get('auth/user', token: token);
    return ProfileResponse.fromJson(response);
  }
}
