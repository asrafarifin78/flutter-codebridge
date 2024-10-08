class UserModel {
  String? sId;
  String? name;
  String? password;
  bool? status;

  UserModel({this.sId, this.name, this.password, this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['password'] = password;
    data['status'] = status;
    return data;
  }
}
