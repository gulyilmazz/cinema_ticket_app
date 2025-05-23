class AuthResponse {
  bool? success;
  User? data;
  String? message;

  AuthResponse({this.success, this.data, this.message});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
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

class User {
  int? id;
  String? name;
  String? email;
  int? roleId;
  String? token;

  User({this.id, this.name, this.email, this.roleId, this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roleId = json['role_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role_id'] = roleId;
    data['token'] = token;
    return data;
  }
}
