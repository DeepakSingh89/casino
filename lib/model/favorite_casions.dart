class FavoriteCasions {
  FavoriteCasions({
    required this.status,
    required this.message,
    required this.favouriteList,
  });
  late final String status;
  late final String message;
  late final List<FavouriteList> favouriteList;

  FavoriteCasions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    favouriteList = List.from(json['favouriteList'])
        .map((e) => FavouriteList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['favouriteList'] = favouriteList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FavouriteList {
  FavouriteList({
    required this.casinoId,
    required this.casinoName,
    required this.casinoDiscription,
    required this.picVersion,
    required this.picId,
    required this.location,
  });
  late final String casinoId;
  late final String casinoName;
  late final String casinoDiscription;
  late final String picVersion;
  late final String picId;
  late final List<double> location;

  FavouriteList.fromJson(Map<String, dynamic> json) {
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    casinoDiscription = json['casinoDiscription'];
    picVersion = json['picVersion'];
    picId = json['picId'];
    location = List.castFrom<dynamic, double>(json['location']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['casinoDiscription'] = casinoDiscription;
    _data['picVersion'] = picVersion;
    _data['picId'] = picId;
    _data['location'] = location;
    return _data;
  }
}
