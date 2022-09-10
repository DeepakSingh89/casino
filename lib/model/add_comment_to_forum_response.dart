class AddCommentToForumResponse {
  AddCommentToForumResponse({
    required this.status,
    required this.message,
    required this.commentList,
  });
  late final String status;
  late final String message;
  late final List<CommentList> commentList;

  AddCommentToForumResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    commentList = List.from(json['commentList'])
        .map((e) => CommentList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['commentList'] = commentList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CommentList {
  CommentList({
    required this.userId,
    required this.comment,
    //required this._id,
  });
  late final String userId;
  late final String comment;
  late final String _id;

  CommentList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    comment = json['comment'];
    _id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['comment'] = comment;
    _data['_id'] = _id;
    return _data;
  }
}
