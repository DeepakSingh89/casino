class AddCasinoForumResponse {
  AddCasinoForumResponse({
    required this.status,
    required this.message,
    required this.casinoForum,
  });
  late final String status;
  late final String message;
  late final CasinoForum casinoForum;

  AddCasinoForumResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    casinoForum = CasinoForum.fromJson(json['casinoForum']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['casinoForum'] = casinoForum.toJson();
    return _data;
  }
}

class CasinoForum {
  CasinoForum({
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
    //required this._id,
    required this.forumLikes,
    required this.forumComment,
    //required this._V,
  });
  late final String casinoForumId;
  late final String casinoForumName;
  late final String casinoForumDiscription;
  late final String userId;
  late final String userName;
  late final String userPicVersion;
  late final String userPicId;
  late final List<dynamic> casinoForumImage;
  late final int numberOfLike;
  late final String createdDate;
  late final String _id;
  late final List<dynamic> forumLikes;
  late final List<dynamic> forumComment;
  late final int _V;

  CasinoForum.fromJson(Map<String, dynamic> json) {
    casinoForumId = json['casinoForumId'];
    casinoForumName = json['casinoForumName'];
    casinoForumDiscription = json['casinoForumDiscription'];
    userId = json['userId'];
    userName = json['userName'];
    userPicVersion = json['userPicVersion'];
    userPicId = json['userPicId'];
    casinoForumImage =
        List.castFrom<dynamic, dynamic>(json['casinoForumImage']);
    numberOfLike = json['numberOfLike'];
    createdDate = json['created_date'];
    _id = json['_id'];
    forumLikes = List.castFrom<dynamic, dynamic>(json['forumLikes']);
    forumComment = List.castFrom<dynamic, dynamic>(json['forumComment']);
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['casinoForumId'] = casinoForumId;
    _data['casinoForumName'] = casinoForumName;
    _data['casinoForumDiscription'] = casinoForumDiscription;
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['userPicVersion'] = userPicVersion;
    _data['userPicId'] = userPicId;
    _data['casinoForumImage'] = casinoForumImage;
    _data['numberOfLike'] = numberOfLike;
    _data['created_date'] = createdDate;
    _data['_id'] = _id;
    _data['forumLikes'] = forumLikes;
    _data['forumComment'] = forumComment;
    _data['__v'] = _V;
    return _data;
  }
}
