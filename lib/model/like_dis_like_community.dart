class LikeDisLikeCommunity {
  LikeDisLikeCommunity({
    required this.status,
    required this.message,
    required this.noOfLikes,
  });
  late final String status;
  late final String message;
  late final int noOfLikes;

  LikeDisLikeCommunity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    noOfLikes = json['noOfLikes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['noOfLikes'] = noOfLikes;
    return _data;
  }
}
