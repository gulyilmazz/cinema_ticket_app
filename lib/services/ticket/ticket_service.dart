// import 'package:cinemaa/models/ticket_response.dart';
// import 'package:cinemaa/services/client_service.dart';

// class TicketsService {
//   final ApiClient _apiClient;

//   TicketsService({ApiClient? apiClient})
//     : _apiClient = apiClient ?? ApiClient();

//   Future<TicketResponse> addTicket({
//     required String token,
//     required String userId,
//     required String showtimeId,
//     required String seatNumber,
//   }) async {
//     try {
//       final body = {
//         'user_id': userId,
//         'showtime_id': showtimeId,
//         'seat_number': seatNumber,
//       };

//       final response = await _apiClient.post(
//         'tickets/ticket-add',
//         token: token,
//         body: body,
//       );

//       return TicketResponse.fromJson(response);
//     } catch (e) {
//       throw Exception('Bilet oluşturma başarısız: $e');
//     }
//   }
// }

import 'package:cinemaa/models/ticket_byuser_response.dart';
import 'package:cinemaa/models/ticket_response.dart';
import 'package:cinemaa/services/client_service.dart';

class TicketsService {
  final ApiClient _apiClient;

  TicketsService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<TicketResponse> addTicket({
    required String token,
    required String userId,
    required String showtimeId,
    required String seatNumber,
  }) async {
    try {
      final body = {
        'user_id': userId,
        'showtime_id': showtimeId,
        'seat_number': seatNumber,
      };

      final response = await _apiClient.post(
        'tickets/ticket-add',
        token: token,
        body: body,
      );

      return TicketResponse.fromJson(response);
    } catch (e) {
      throw Exception('Bilet oluşturma başarısız: $e');
    }
  }

  Future<TicketByUserResponse> getTicketsByUser({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await _apiClient.get(
        'tickets/ticket-by-user/$userId',
        token: token,
      );
      return TicketByUserResponse.fromJson(response);
    } catch (e) {
      throw Exception('Kullanıcı biletleri alınamadı: $e');
    }
  }
}
