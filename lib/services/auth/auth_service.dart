import 'package:cinemaa/models/auth_response.dart';
import 'package:cinemaa/services/client_service.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final body = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };

    final response = await _apiClient.post('auth/register', body: body);

    return AuthResponse.fromJson(response);
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final body = {"email": email, "password": password};

    final response = await _apiClient.post('auth/login', body: body);

    final authResponse = AuthResponse.fromJson(response);

    //await AuthStorage.saveId(authResponse.data.user.id);

    return authResponse;
  }
}

// Future<AuthResponse> logout() async {
//   final token = await AuthStorage.getToken();
//   final response = await _apiClient.post('auth/logout', token: token);

//   return AuthResponse.fromJson(response);
// }
