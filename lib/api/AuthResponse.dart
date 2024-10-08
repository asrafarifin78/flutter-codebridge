class AuthResponse {
  String? _status;

  AuthResponse({String? status}) {
    if (status != null) {
      _status = status;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;

  AuthResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    return data;
  }
}