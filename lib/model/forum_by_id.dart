class ForumById {
  ForumById({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final List<Data> data;

  ForumById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    // required this._id,
    required this.casinoForumId,
    required this.casinoForumName,
    required this.casinoForumDiscription,
    required this.userId,
    required this.userName,
    required this.userPicVersion,
    required this.userPicId,
    required this.casinoForumImage,
    required this.numberOfLike,
    required this.createdDate,
    required this.forumLikes,
    required this.forumComment,
    // required this._V,
  });
  late final String _id;
  late final String casinoForumId;
  late final String casinoForumName;
  late final String casinoForumDiscription;
  late final String userId;
  late final String userName;
  late final String userPicVersion;
  late final String userPicId;
  late final List<CasinoForumImage> casinoForumImage;
  late final int numberOfLike;
  late final String createdDate;
  late final List<ForumLikes> forumLikes;
  late final List<ForumComment> forumComment;
  late final int _V;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    casinoForumId = json['casinoForumId'];
    casinoForumName = json['casinoForumName'];
    casinoForumDiscription = json['casinoForumDiscription'];
    userId = json['userId'];
    userName = json['userName'];
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    casinoForumImage = List.from(json['casinoForumImage'])
        .map((e) => CasinoForumImage.fromJson(e))
        .toList();
    numberOfLike = json['numberOfLike'];
    createdDate = json['created_date'];
    forumLikes = List.from(json['forumLikes'])
        .map((e) => ForumLikes.fromJson(e))
        .toList();
    forumComment = List.from(json['forumComment'])
        .map((e) => ForumComment.fromJson(e))
        .toList();
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['casinoForumId'] = casinoForumId;
    _data['casinoForumName'] = casinoForumName;
    _data['casinoForumDiscription'] = casinoForumDiscription;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['casinoForumImage'] =
        casinoForumImage.map((e) => e.toJson()).toList();
    _data['numberOfLike'] = numberOfLike;
    _data['created_date'] = createdDate;
    _data['forumLikes'] = forumLikes.map((e) => e.toJson()).toList();
    _data['forumComment'] = forumComment.map((e) => e.toJson()).toList();
    _data['__v'] = _V;
    return _data;
  }
}

class CasinoForumImage {
  CasinoForumImage({
    required this.picVersion,
    required this.picId,
    //  required this._id,
  });
  late final String picVersion;
  late final String picId;
  late final String _id;

  CasinoForumImage.fromJson(Map<String, dynamic> json) {
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

class ForumLikes {
  ForumLikes({
    required this.userId,
    //required this._id,
  });
  late final String userId;
  late final String _id;

  ForumLikes.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    _id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['_id'] = _id;
    return _data;
  }
}

class ForumComment {
  ForumComment({
    required this.userPicVersion,
    required this.userPicId,
    required this.userId,
    required this.comment,
    //required this._id,
  });
  late final String userPicVersion;
  late final String userPicId;
  late final String userId;
  late final String comment;
  late final String _id;

  ForumComment.fromJson(Map<String, dynamic> json) {
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    userId = json['userId'];
    comment = json['comment'];
    _id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['userId'] = userId;
    _data['comment'] = comment;
    _data['_id'] = _id;
    return _data;
  }
}
