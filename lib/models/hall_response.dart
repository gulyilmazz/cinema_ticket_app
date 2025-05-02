class SalonResponse {
  bool? success;
  List<CinemaHall>? data;
  String? message;

  SalonResponse({this.success, this.data, this.message});

  SalonResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CinemaHall>[];
      json['data'].forEach((v) {
        data!.add(CinemaHall.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class CinemaHall {
  int? id;
  int? cityId;
  String? name;
  String? address;
  String? latitude;
  String? longitude;
  int? totalCapacity;
  String? phone;
  String? description;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  City? city;

  CinemaHall({
    this.id,
    this.cityId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.totalCapacity,
    this.phone,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.city,
    required bool success,
    required String message,
  });

  CinemaHall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    totalCapacity = json['total_capacity'];
    phone = json['phone'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['name'] = name;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['total_capacity'] = totalCapacity;
    data['phone'] = phone;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  City({this.id, this.name, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
