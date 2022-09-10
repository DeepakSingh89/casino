class RestaurantReviewRating {
  RestaurantReviewRating({
    required this.status,
    required this.message,
    required this.restaurantDetails,
  });
  late final String status;
  late final String message;
  late final RestaurantDetails restaurantDetails;

  RestaurantReviewRating.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    restaurantDetails = RestaurantDetails.fromJson(json['restaurantDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['restaurantDetails'] = restaurantDetails.toJson();
    return _data;
  }
}

class RestaurantDetails {
  RestaurantDetails({
    required this.restaurantReviewRatingId,
    required this.restaurantId,
    required this.restaurantName,
    required this.casinoId,
    required this.casinoName,
    required this.userId,
    required this.userName,
    required this.userPicVersion,
    required this.userPicId,
    required this.review,
    required this.restaurantReviewImage,
    required this.rating,
    required this.lastRating,
    required this.createdDate,
    //required this._id,
    required this.restaurantImage,
    //required this._V,
  });
  late final String restaurantReviewRatingId;
  late final String restaurantId;
  late final String restaurantName;
  late final String casinoId;
  late final String casinoName;
  late final String userId;
  late final String userName;
  late final String userPicVersion;
  late final String userPicId;
  late final String review;
  late final List<dynamic> restaurantReviewImage;
  late final int rating;
  late final int lastRating;
  late final String createdDate;
  late final String _id;
  late final List<dynamic> restaurantImage;
  late final int _V;

  RestaurantDetails.fromJson(Map<String, dynamic> json) {
    restaurantReviewRatingId = json['restaurantReviewRatingId'];
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    userId = json['userId'];
    userName = json['userName'];
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    review = json['review'];
    restaurantReviewImage =
        List.castFrom<dynamic, dynamic>(json['restaurantReviewImage']);
    rating = json['rating'];
    lastRating = json['last_rating'];
    createdDate = json['created_date'];
    _id = json['_id'];
    restaurantImage = List.castFrom<dynamic, dynamic>(json['restaurantImage']);
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['restaurantReviewRatingId'] = restaurantReviewRatingId;
    _data['restaurantId'] = restaurantId;
    _data['restaurantName'] = restaurantName;
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['review'] = review;
    _data['restaurantReviewImage'] = restaurantReviewImage;
    _data['rating'] = rating;
    _data['last_rating'] = lastRating;
    _data['created_date'] = createdDate;
    _data['_id'] = _id;
    _data['restaurantImage'] = restaurantImage;
    _data['__v'] = _V;
    return _data;
  }
}
