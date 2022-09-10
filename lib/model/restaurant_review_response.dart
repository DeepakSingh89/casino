class RestaurantReviewResponse {
  RestaurantReviewResponse({
    required this.status,
    required this.message,
    required this.restaurantData,
  });
  late final String status;
  late final String message;
  late final List<RestaurantData> restaurantData;

  RestaurantReviewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    restaurantData = List.from(json['restaurantData'])
        .map((e) => RestaurantData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['restaurantData'] = restaurantData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RestaurantData {
  RestaurantData({
    required this.userPicVersion,
    required this.userPicId,

    //required this._id,
    required this.restaurantReviewRatingId,
    required this.restaurantId,
    required this.restaurantName,
    required this.casinoId,
    required this.casinoName,
    required this.userId,
    required this.userName,
    required this.review,
    required this.restaurantReviewImage,
    required this.rating,
    required this.lastRating,
    required this.createdDate,
    required this.restaurantImage,
    required this.restaurantLocation,
    //required this._V,
  });
  late final String userPicVersion;
  late final String userPicId;
  late final String _id;
  late final String restaurantReviewRatingId;
  late final String restaurantId;
  late final String restaurantName;
  late final String casinoId;
  late final String casinoName;
  late final String userId;
  late final String userName;
  late final String review;
  late final List<dynamic> restaurantReviewImage;
  late final int rating;
  late final int lastRating;
  late final String createdDate;
  late final List<CasinoReviewImage> restaurantImage;
  late final String restaurantLocation;
  // late final int _V;

  RestaurantData.fromJson(Map<String, dynamic> json) {
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    _id = json['_id'];
    restaurantReviewRatingId = json['restaurantReviewRatingId'];
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    userId = json['userId'];
    userName = json['userName'];
    review = json['review'];
    restaurantReviewImage =
        List.castFrom<dynamic, dynamic>(json['restaurantReviewImage']);

    rating = json['rating'];
    lastRating = json['last_rating'];
    createdDate = json['created_date'];
    restaurantLocation = json['restaurantLocation'];

    restaurantImage = List.from(json['restaurantImage'])
        .map((e) => CasinoReviewImage.fromJson(e))
        .toList();

    //_V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['_id'] = _id;
    _data['restaurantReviewRatingId'] = restaurantReviewRatingId;
    _data['restaurantId'] = restaurantId;
    _data['restaurantName'] = restaurantName;
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['review'] = review;
    _data['restaurantReviewImage'] = restaurantReviewImage;
    _data['rating'] = rating;
    _data['last_rating'] = lastRating;
    _data['created_date'] = createdDate;
    _data['restaurantImage'] = restaurantImage;
    _data['restaurantLocation'] = restaurantLocation;

    //_data['__v'] = _V;
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
