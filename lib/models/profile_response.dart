class ProfileResponse {
  bool? success;
  ProfileData? data;
  String? message;

  ProfileResponse({this.success, this.data, this.message});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  int? id;
  String? name;
  String? email;
  int? roleId;
  String? roleName;
  String? createdAt;

  ProfileData({
    this.id,
    this.name,
    this.email,
    this.roleId,
    this.roleName,
    this.createdAt,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role_id'] = roleId;
    data['role_name'] = roleName;
    data['created_at'] = createdAt;
    return data;
  }
}
