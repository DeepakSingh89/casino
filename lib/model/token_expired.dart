class TokenExpired {
  TokenExpired({
    required this.status,
    required this.message,
    required this.token,
  });
  late final String status;
  late final String message;
  late final String token;

  TokenExpired.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (message != null) {
      token = json['token'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['token'] = token;
    return _data;
  }
}
