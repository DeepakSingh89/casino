class UserLogin {
  UserLogin({
    required this.status,
    required this.message,
    required this.user,
    required this.ads,
    required this.token,
  });
  late final String status;
  late final String message;
  late final User user;
  late final List<Ads> ads;
  late final String token;

  UserLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    if (json['Ads'] != null) {
      ads = List.from(json['Ads']).map((e) => Ads.fromJson(e)).toList();
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
    _data['Ads'] = ads.map((e) => e.toJson()).toList();
    _data['token'] = token;
    return _data;
  }
}

class User {
  User({
    //   required this._id,
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
    required this.paymentType,
    required this.paymentAmount,
    required this.noOfReviews,
    required this.favourite,
    required this.deviceToken,
    required this.created,
    required this.OTP,
    //required this._V,
  });
  late final String _id;
  late final String userId;
  late final String username;
  late final String email;
  late final String password;
  late final int number;
  late final String picVersion;
  late final String picId;
  late final List<String> location;
  late final double lat;
  late final double long;
  late final String language;
  late final bool activeUser;
  late final bool subscription;
  late final String paymentType;
  late final int paymentAmount;
  late final int noOfReviews;
  late final List<Favourite> favourite;
  late final String deviceToken;
  late final String created;
  late final int OTP;
  late final int _V;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    picVersion = json['picVersion'];
    picId = json['picId'];
    location = List.castFrom<dynamic, String>(json['location']);
    lat = json['lat'];
    long = json['long'];
    language = json['language'];
    activeUser = json['activeUser'];
    subscription = json['subscription'];
    paymentType = json['paymentType'];
    paymentAmount = json['paymentAmount'];
    noOfReviews = json['noOfReviews'];
    favourite =
        List.from(json['favourite']).map((e) => Favourite.fromJson(e)).toList();
    deviceToken = json['deviceToken'];
    created = json['created'];
    OTP = json['OTP'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
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
    _data['paymentType'] = paymentType;
    _data['paymentAmount'] = paymentAmount;
    _data['noOfReviews'] = noOfReviews;
    _data['favourite'] = favourite.map((e) => e.toJson()).toList();
    _data['deviceToken'] = deviceToken;
    _data['created'] = created;
    _data['OTP'] = OTP;
    _data['__v'] = _V;
    return _data;
  }
}

class Favourite {
  Favourite({
    required this.casinoId,
    required this.casinoName,
    required this.casinoDiscription,
    required this.picVersion,
    required this.picId,
    required this.location,
  });
  late final String casinoId;
  late final String casinoName;
  late final String casinoDiscription;
  late final String picVersion;
  late final String picId;
  late final List<double> location;

  Favourite.fromJson(Map<String, dynamic> json) {
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    casinoDiscription = json['casinoDiscription'];
    picVersion = json['picVersion'];
    picId = json['picId'];
    location = List.castFrom<dynamic, double>(json['location']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['casinoDiscription'] = casinoDiscription;
    _data['picVersion'] = picVersion;
    _data['picId'] = picId;
    _data['location'] = location;
    return _data;
  }
}

class Ads {
  Ads({
    // required this._id,
    required this.adsId,
    required this.picVersion,
    required this.picId,
    required this.adsUrl,
    //  required this._V,
  });
  late final String _id;
  late final String adsId;
  late final String picVersion;
  late final String picId;
  late final String adsUrl;
  late final int _V;

  Ads.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    adsId = json['adsId'];
    picVersion = json['picVersion'];
    picId = json['picId'];
    adsUrl = json['adsUrl'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['adsId'] = adsId;
    _data['picVersion'] = picVersion;
    _data['picId'] = picId;
    _data['adsUrl'] = adsUrl;
    _data['__v'] = _V;
    return _data;
  }
}
