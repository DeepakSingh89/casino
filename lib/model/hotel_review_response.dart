class HotelReviewResponse {
  HotelReviewResponse({
    required this.status,
    required this.message,
    required this.hotelData,
  });
  late final String status;
  late final String message;
  late final List<HotelData> hotelData;

  HotelReviewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    hotelData =
        List.from(json['hotelData']).map((e) => HotelData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['hotelData'] = hotelData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class HotelData {
  HotelData({
    required this.userPicVersion,
    required this.userPicId,
    required this.hotelReviewRatingId,
    required this.hotelId,
    required this.hotelName,
    required this.casinoId,
    required this.casinoName,
    required this.userId,
    required this.userName,
    required this.review,
    required this.hotelReviewImage,
    required this.rating,
    required this.lastRating,
    required this.createdDate,
    required this.hotelImage,
    required this.hotelLocation,
  });
  late final String userPicVersion;
  late final String userPicId;
  late final String _id;
  late final String hotelReviewRatingId;
  late final String hotelId;
  late final String hotelName;
  late final String casinoId;
  late final String casinoName;
  late final String userId;
  late final String userName;
  late final String review;
  late final List<dynamic> hotelReviewImage;
  late final int rating;
  late final int lastRating;
  late final String createdDate;
  late final List<CasinoReviewImage> hotelImage;
  late final int _V;
  late final String hotelLocation;

  HotelData.fromJson(Map<String, dynamic> json) {
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    _id = json['_id'];
    hotelReviewRatingId = json['hotelReviewRatingId'];
    hotelId = json['hotelId'];
    hotelName = json['hotelName'];
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    userId = json['userId'];
    userName = json['userName'];
    review = json['review'];
    hotelReviewImage =
        List.castFrom<dynamic, dynamic>(json['hotelReviewImage']);
    rating = json['rating'];
    lastRating = json['last_rating'];
    createdDate = json['created_date'];
    hotelLocation = json['hotelLocation'];

    //    = List.castFrom<dynamic, dynamic>(json['hotelImage']);

    hotelImage = List.from(json['hotelImage'])
        .map((e) => CasinoReviewImage.fromJson(e))
        .toList();

    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['_id'] = _id;
    _data['hotelReviewRatingId'] = hotelReviewRatingId;
    _data['hotelId'] = hotelId;
    _data['hotelName'] = hotelName;
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['review'] = review;
    _data['hotelReviewImage'] = hotelReviewImage;
    _data['rating'] = rating;
    _data['last_rating'] = lastRating;
    _data['created_date'] = createdDate;
    _data['hotelImage'] = hotelImage;

    _data['hotelLocation'] = hotelLocation;
    _data['__v'] = _V;
    return _data;
  }
}

class CasinoReviewImage {
  CasinoReviewImage({
    required this.picVersion,
    required this.picId,
    // required this._id,
  });
  late final String picVersion;
  late final String picId;
  late final String _id;

  CasinoReviewImage.fromJson(Map<String, dynamic> json) {
    picVersion = json['picVersion'];
    picId = json['picId'];
    _id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['picVersion'] = picVersion;
    _data['picId'] = picId;
    _data['_id'] = _id;
    return _data;
  }
}
