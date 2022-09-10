import 'dart:convert';

class VerifyOtpResponse {
  String status = "";
  String message = "";

  VerifyOtpResponse({required this.status, required this.message});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
