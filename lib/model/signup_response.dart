// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SignupResponse {
  SignupResponse({
    required this.status,
    required this.message,
    required this.user,
    required this.token,
  });
  late final String status;
  late final String message;
  late final User user;
  late final String token;

  SignupResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }

    if (json['token'] != null) {
      token = json['token'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['user'] = user.toJson();
    _data['token'] = token;
    return _data;
  }
}

class User {
  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.number,
    required this.picVersion,
    required this.picId,
    required this.location,
    required this.lat,
    required this.long,
    required this.language,
    required this.activeUser,
    required this.subscription,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    required this.paymentType,
    required this.paymentAmount,
    required this.deviceToken,
    required this.created,
    this.modified,
    required this.OTP,
    required this.favourite,
  });
  late final String userId;
  late final String username;
  late final String email;
  late final String password;
  late final int number;
  late final String picVersion;
  late final String picId;
  late final List<double> location;
  late final double lat;
  late final double long;
  late final String language;
  late final bool activeUser;
  late final bool subscription;
  late final Null subscriptionStartDate;
  late final Null subscriptionEndDate;
  late final String paymentType;
  late final int paymentAmount;
  late final String deviceToken;
  late final String created;
  late final Null modified;
  late final int OTP;

  late final List<dynamic> favourite;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    picVersion = json['picVersion'];
    picId = json['picId'];
    location = List.castFrom<dynamic, double>(json['location']);
    lat = json['lat'];
    long = json['long'];
    language = json['language'];
    activeUser = json['activeUser'];
    subscription = json['subscription'];
    subscriptionStartDate = null;
    subscriptionEndDate = null;
    paymentType = json['paymentType'];
    paymentAmount = json['paymentAmount'];
    deviceToken = json['deviceToken'];
    created = json['created'];
    modified = null;
    OTP = json['OTP'];

    favourite = List.castFrom<dynamic, dynamic>(json['favourite']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['username'] = username;
    _data['email'] = email;
    _data['password'] = password;
    _data['number'] = number;
    _data['picVersion'] = picVersion;
    _data['picId'] = picId;
    _data['location'] = location;
    _data['lat'] = lat;
    _data['long'] = long;
    _data['language'] = language;
    _data['activeUser'] = activeUser;
    _data['subscription'] = subscription;
    _data['subscriptionStartDate'] = subscriptionStartDate;
    _data['subscriptionEndDate'] = subscriptionEndDate;
    _data['paymentType'] = paymentType;
    _data['paymentAmount'] = paymentAmount;
    _data['deviceToken'] = deviceToken;
    _data['created'] = created;
    _data['modified'] = modified;
    _data['OTP'] = OTP;

    _data['favourite'] = favourite;

    return _data;
  }
}
