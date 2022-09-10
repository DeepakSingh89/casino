class CasinoUserReviewRating {
  CasinoUserReviewRating({
    required this.status,
    required this.message,
    required this.casinoData,
  });
  late final String status;
  late final String message;
  late final List<CasinoData> casinoData;

  CasinoUserReviewRating.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    casinoData = List.from(json['casinoData'])
        .map((e) => CasinoData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['casinoData'] = casinoData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CasinoData {
  CasinoData({
    //  required this._id,
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
    this.updatedDate,
    // required this._V,
  });
  late final String _id;
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
  late final List<CasinoReviewImage> casinoReviewImage;
  late final int rating;
  late final int lastRating;
  late final String createdDate;
  late final Null updatedDate;
  late final int _V;

  CasinoData.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
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
    casinoReviewImage = List.from(json['casinoReviewImage'])
        .map((e) => CasinoReviewImage.fromJson(e))
        .toList();
    rating = json['rating'];
    lastRating = json['last_rating'];
    createdDate = json['created_date'];
    updatedDate = null;
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
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
    _data['casinoReviewImage'] =
        casinoReviewImage.map((e) => e.toJson()).toList();
    _data['rating'] = rating;
    _data['last_rating'] = lastRating;
    _data['created_date'] = createdDate;
    _data['updated_date'] = updatedDate;
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
