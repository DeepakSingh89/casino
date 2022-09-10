class AddHotelReview {
  AddHotelReview({
    required this.status,
    required this.message,
    required this.hotelDetails,
  });
  late final String status;
  late final String message;
  late final HotelDetails hotelDetails;

  AddHotelReview.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    hotelDetails = HotelDetails.fromJson(json['hotelDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['hotelDetails'] = hotelDetails.toJson();
    return _data;
  }
}

class HotelDetails {
  HotelDetails({
    required this.hotelReviewRatingId,
    required this.hotelId,
    required this.hotelName,
    required this.casinoId,
    required this.casinoName,
    required this.userId,
    required this.userName,
    required this.review,
    required this.userPicVersion,
    required this.userPicId,
    required this.hotelReviewImage,
    required this.rating,
    required this.lastRating,
    required this.createdDate,
    required this.hotelImage,
  });
  late final String hotelReviewRatingId;
  late final String hotelId;
  late final String hotelName;
  late final String casinoId;
  late final String casinoName;
  late final String userId;
  late final String userName;
  late final String review;
  late final String userPicVersion;
  late final String userPicId;
  late final List<dynamic> hotelReviewImage;
  late final int rating;
  late final int lastRating;
  late final String createdDate;
  late final String _id;
  late final List<dynamic> hotelImage;
  late final int _V;

  HotelDetails.fromJson(Map<String, dynamic> json) {
    hotelReviewRatingId = json['hotelReviewRatingId'];
    hotelId = json['hotelId'];
    hotelName = json['hotelName'];
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    userId = json['userId'];
    userName = json['userName'];
    review = json['review'];
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    hotelReviewImage =
        List.castFrom<dynamic, dynamic>(json['hotelReviewImage']);
    rating = json['rating'];
    lastRating = json['last_rating'];
    createdDate = json['created_date'];
    _id = json['_id'];
    hotelImage = List.castFrom<dynamic, dynamic>(json['hotelImage']);
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hotelReviewRatingId'] = hotelReviewRatingId;
    _data['hotelId'] = hotelId;
    _data['hotelName'] = hotelName;
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['review'] = review;
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['hotelReviewImage'] = hotelReviewImage;
    _data['rating'] = rating;
    _data['last_rating'] = lastRating;
    _data['created_date'] = createdDate;
    _data['_id'] = _id;
    _data['hotelImage'] = hotelImage;
    _data['__v'] = _V;
    return _data;
  }
}
