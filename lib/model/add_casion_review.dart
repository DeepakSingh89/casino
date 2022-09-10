class AddCasionReview {
  AddCasionReview({
    required this.status,
    required this.message,
    required this.noOfReviews,
  });
  late final String status;
  late final String message;
  late final int noOfReviews;

  AddCasionReview.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    noOfReviews = json['noOfReviews'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['noOfReviews'] = noOfReviews;
    return _data;
  }
}

/*class AddCasionReview {
  AddCasionReview({
    required this.status,
    required this.message,
    required this.casinoReviewDetails,
  });
  late final String status;
  late final String message;
  late final CasinoReviewDetails casinoReviewDetails;

  AddCasionReview.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    casinoReviewDetails =
        CasinoReviewDetails.fromJson(json['casinoReviewDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['casinoReviewDetails'] = casinoReviewDetails.toJson();
    return _data;
  }
}

class CasinoReviewDetails {
  CasinoReviewDetails({
    required this.casinoReviewRatingId,
    required this.casinoId,
    required this.casinoName,
    required this.userId,
    required this.userName,
    required this.casinoPicVersion,
    required this.casinoPicId,
    required this.userPicVersion,
    required this.userPicId,
    required this.review,
    required this.casinoReviewImage,
    required this.rating,
    required this.lastRating,
    required this.createdDate,
    //required this._id,
    //required this._V,
  });
  late final String casinoReviewRatingId;
  late final String casinoId;
  late final String casinoName;
  late final String userId;
  late final String userName;
  late final String casinoPicVersion;
  late final String casinoPicId;
  late final String userPicVersion;
  late final String userPicId;
  late final String review;
  late final List<dynamic> casinoReviewImage;
  late final int rating;
  late final int lastRating;
  late final String createdDate;
  late final String _id;
  late final int _V;

  CasinoReviewDetails.fromJson(Map<String, dynamic> json) {
    casinoReviewRatingId = json['casinoReviewRatingId'];
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    userId = json['userId'];
    userName = json['userName'];
    casinoPicVersion = json['casinoPicVersion'];
    casinoPicId = json['casinoPicId'];
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    review = json['review'];
    casinoReviewImage =
        List.castFrom<dynamic, dynamic>(json['casinoReviewImage']);
    rating = json['rating'];
    lastRating = json['last_rating'];
    createdDate = json['created_date'];
    _id = json['_id'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['casinoReviewRatingId'] = casinoReviewRatingId;
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['casinoPicVersion'] = casinoPicVersion;
    _data['casinoPicId'] = casinoPicId;
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['review'] = review;
    _data['casinoReviewImage'] = casinoReviewImage;
    _data['rating'] = rating;
    _data['last_rating'] = lastRating;
    _data['created_date'] = createdDate;
    _data['_id'] = _id;
    _data['__v'] = _V;
    return _data;
  }
}*/
