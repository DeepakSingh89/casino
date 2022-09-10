class AddRestaurant {
  AddRestaurant({
    required this.status,
    required this.message,
    required this.restaurantDetails,
  });
  late final String status;
  late final String message;
  late final RestaurantDetails restaurantDetails;

  AddRestaurant.fromJson(Map<String, dynamic> json) {
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
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantDiscription,
    required this.casinoId,
    required this.restaurantImage,
    required this.created,
    //required this._id,
    //  required this._V,
  });
  late final String restaurantId;
  late final String restaurantName;
  late final String restaurantDiscription;
  late final String casinoId;
  late final List<RestaurantImage> restaurantImage;
  late final String created;
  late final String _id;
  late final int _V;

  RestaurantDetails.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    restaurantDiscription = json['restaurantDiscription'];
    casinoId = json['casinoId'];
    restaurantImage = List.from(json['restaurantImage'])
        .map((e) => RestaurantImage.fromJson(e))
        .toList();
    created = json['created'];
    _id = json['_id'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['restaurantId'] = restaurantId;
    _data['restaurantName'] = restaurantName;
    _data['restaurantDiscription'] = restaurantDiscription;
    _data['casinoId'] = casinoId;
    _data['restaurantImage'] = restaurantImage.map((e) => e.toJson()).toList();
    _data['created'] = created;
    _data['_id'] = _id;
    _data['__v'] = _V;
    return _data;
  }
}

class RestaurantImage {
  RestaurantImage({
    required this.picVersion,
    required this.picId,
    // required this._id,
  });
  late final String picVersion;
  late final String picId;
  late final String _id;

  RestaurantImage.fromJson(Map<String, dynamic> json) {
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
