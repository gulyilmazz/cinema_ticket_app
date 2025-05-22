class PaymentResponse {
  bool? success;
  Data? data;
  String? message;

  PaymentResponse({this.success, this.data, this.message});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? ticketId;
  String? paymentMethod;
  String? amount;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.ticketId,
    this.paymentMethod,
    this.amount,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    data['payment_method'] = paymentMethod;
    data['amount'] = amount;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
