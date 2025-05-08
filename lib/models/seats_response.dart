class SeatResponse {
  final bool success;
  final String message;
  final SeatData data;

  SeatResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SeatResponse.fromJson(Map<String, dynamic> json) {
    return SeatResponse(
      success: json['success'],
      message: json['message'],
      data: SeatData.fromJson(json['data']),
    );
  }
}

class SeatData {
  final int id;
  final int cinemaHallId;
  final SeatDataDetail seatData;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;

  SeatData({
    required this.id,
    required this.cinemaHallId,
    required this.seatData,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory SeatData.fromJson(Map<String, dynamic> json) {
    return SeatData(
      id: json['id'],
      cinemaHallId: json['cinema_hall_id'],
      seatData: SeatDataDetail.fromJson(json['seat_data']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
    );
  }
}

class SeatDataDetail {
  final Map<String, List<Seat>> seats;
  final Layout layout;

  SeatDataDetail({required this.seats, required this.layout});

  factory SeatDataDetail.fromJson(Map<String, dynamic> json) {
    final seatsMap = <String, List<Seat>>{};
    json['seats'].forEach((key, value) {
      seatsMap[key] = List<Seat>.from(value.map((e) => Seat.fromJson(e)));
    });

    return SeatDataDetail(
      seats: seatsMap,
      layout: Layout.fromJson(json['layout']),
    );
  }
}

class Seat {
  final String id;
  final String row;
  final String type;
  final int price;
  final int number;
  final String status;

  Seat({
    required this.id,
    required this.row,
    required this.type,
    required this.price,
    required this.number,
    required this.status,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      row: json['row'],
      type: json['type'],
      price: json['price'],
      number: json['number'],
      status: json['status'],
    );
  }
}

class Layout {
  final int rows;
  final int seatsPerRow;

  Layout({required this.rows, required this.seatsPerRow});

  factory Layout.fromJson(Map<String, dynamic> json) {
    return Layout(rows: json['rows'], seatsPerRow: json['seatsPerRow']);
  }
}
