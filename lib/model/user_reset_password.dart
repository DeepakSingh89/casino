class UserResetPassword {
  UserResetPassword({
    required this.Status,
    required this.message,
  });
  late final String Status;
  late final String message;

  UserResetPassword.fromJson(Map<String, dynamic> json) {
    Status = json['Status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Status'] = Status;
    _data['message'] = message;
    return _data;
  }
}
