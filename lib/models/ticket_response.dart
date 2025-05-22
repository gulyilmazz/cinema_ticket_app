class TicketResponse {
  bool? success;
  TicketData? data;
  String? message;

  TicketResponse({this.success, this.data, this.message});

  TicketResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TicketData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class TicketData {
  String? userId;
  String? showtimeId;
  String? seatNumber;
  String? ticketCode;
  String? price;
  String? updatedAt;
  String? createdAt;
  int? id;

  TicketData({
    this.userId,
    this.showtimeId,
    this.seatNumber,
    this.ticketCode,
    this.price,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  TicketData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    showtimeId = json['showtime_id'];
    seatNumber = json['seat_number'];
    ticketCode = json['ticket_code'];
    price = json['price'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['showtime_id'] = showtimeId;
    data['seat_number'] = seatNumber;
    data['ticket_code'] = ticketCode;
    data['price'] = price;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
