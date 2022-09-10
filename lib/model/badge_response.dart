class BadgeResponse {
  BadgeResponse({
    required this.status,
    required this.message,
    required this.badge,
  });
  late final String status;
  late final String message;
  late final List<Badge> badge;

  BadgeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    badge = List.from(json['badge']).map((e) => Badge.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['badge'] = badge.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Badge {
  Badge({
    // required this._id,
    required this.badgeId,
    required this.badgeName,
    required this.badgePoint,
    required this.badgePicId,
    required this.badgePicVersion,
    required this.badgeDiscription,
    required this.createdDate,
    //required this._V,
  });
  //late final String _id;
  late final String badgeId;
  late final String badgeName;
  late final String badgePoint;
  late final String badgePicId;
  late final String badgePicVersion;
  late final String badgeDiscription;
  late final String createdDate;
  //late final int _V;

  Badge.fromJson(Map<String, dynamic> json) {
    //_id = json['_id'];
    badgeId = json['badgeId'];
    badgeName = json['badgeName'];
    badgePoint = json['badgePoint'];
    badgePicId = json['badgePicId'];
    badgePicVersion = json['badgePicVersion'];
    badgeDiscription = json['badgeDiscription'];
    if (json['created_date'] != null)
      createdDate = json['created_date'];
    else
      createdDate = "12/02/2021";
    // _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['_id'] = _id;
    _data['badgeId'] = badgeId;
    _data['badgeName'] = badgeName;
    _data['badgePoint'] = badgePoint;
    _data['badgePicId'] = badgePicId;
    _data['badgePicVersion'] = badgePicVersion;
    _data['badgeDiscription'] = badgeDiscription;
    _data['created_date'] = createdDate;
    // _data['__v'] = _V;
    return _data;
  }
}
