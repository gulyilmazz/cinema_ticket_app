class PaymentResponse {
  bool? success;
  Data? data;
  String? message;

  PaymentResponse({this.success, this.data, this.message});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['payment_method'] = this.paymentMethod;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
