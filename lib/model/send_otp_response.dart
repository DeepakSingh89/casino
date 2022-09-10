import 'dart:convert';

class SendOtpResponse {
  String status = "";
  String message = "";

  SendOtpResponse({required this.status, required this.message});

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
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
