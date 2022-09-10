class ForumReviewRatingResponse {
  ForumReviewRatingResponse({
    required this.status,
    required this.message,
    required this.forumDetails,
  });
  late final String status;
  late final String message;
  late ForumDetails forumDetails;

  ForumReviewRatingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    forumDetails = ForumDetails.fromJson(json['ForumDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['ForumDetails'] = forumDetails.toJson();
    return _data;
  }
}

class ForumDetails {
  ForumDetails({
    required this.forumReviewRatingId,
    required this.forumId,
    required this.forumName,
    required this.casinoId,
    required this.casinoName,
    required this.userId,
    required this.userName,
    required this.userPicVersion,
    required this.userPicId,
    required this.review,
    required this.forumReviewImage,
    required this.rating,
    required this.lastRating,
    required this.createdDate,
    // required this._id,
    //required this._V,
  });
  late final String forumReviewRatingId;
  late final String forumId;
  late final String forumName;
  late final String casinoId;
  late final String casinoName;
  late final String userId;
  late final String userName;
  late final String userPicVersion;
  late final String userPicId;
  late final String review;
  late final List<dynamic> forumReviewImage;
  late final int rating;
  late final int lastRating;
  late final String createdDate;
  late final String _id;
  late final int _V;

  ForumDetails.fromJson(Map<String, dynamic> json) {
    forumReviewRatingId = json['forumReviewRatingId'];
    forumId = json['forumId'];
    forumName = json['forumName'];
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    userId = json['userId'];
    userName = json['userName'];
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    review = json['review'];
    forumReviewImage =
        List.castFrom<dynamic, dynamic>(json['forumReviewImage']);
    rating = json['rating'];
    lastRating = json['last_rating'];
    createdDate = json['created_date'];
    _id = json['_id'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['forumReviewRatingId'] = forumReviewRatingId;
    _data['forumId'] = forumId;
    _data['forumName'] = forumName;
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['review'] = review;
    _data['forumReviewImage'] = forumReviewImage;
    _data['rating'] = rating;
    _data['last_rating'] = lastRating;
    _data['created_date'] = createdDate;
    _data['_id'] = _id;
    _data['__v'] = _V;
    return _data;
  }
}
