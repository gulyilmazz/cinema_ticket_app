class CinemahallResponse {
  bool? success;
  List<CinemaResponse>? data;
  String? message;

  CinemahallResponse({this.success, this.data, this.message});

  CinemahallResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CinemaResponse>[];
      json['data'].forEach((v) {
        data!.add(CinemaResponse.fromJson(v));
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

class CinemaResponse {
  int? id;
  int? cinemaId;
  String? name;
  int? capacity;
  String? type;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  CinemaResponse({
    this.id,
    this.cinemaId,
    this.name,
    this.capacity,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  CinemaResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cinemaId = json['cinema_id'];
    name = json['name'];
    capacity = json['capacity'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cinema_id'] = cinemaId;
    data['name'] = name;
    data['capacity'] = capacity;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
