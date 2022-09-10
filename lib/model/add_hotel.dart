class AddHotel {
  AddHotel({
    required this.status,
    required this.message,
    required this.hotelDetails,
  });
  late final String status;
  late final String message;
  late final HotelDetails hotelDetails;

  AddHotel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    hotelDetails = HotelDetails.fromJson(json['hotelDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['hotelDetails'] = hotelDetails.toJson();
    return _data;
  }
}

class HotelDetails {
  HotelDetails({
    required this.hotelId,
    required this.hotelName,
    required this.hotelDiscription,
    required this.casinoId,
    required this.hotelImage,
    required this.created,
    //required this._id,
    //required this._V,
  });
  late final String hotelId;
  late final String hotelName;
  late final String hotelDiscription;
  late final String casinoId;
  late final List<HotelImage> hotelImage;
  late final String created;
  late final String _id;
  late final int _V;

  HotelDetails.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotelId'];
    hotelName = json['hotelName'];
    hotelDiscription = json['hotelDiscription'];
    casinoId = json['casinoId'];
    hotelImage = List.from(json['hotelImage'])
        .map((e) => HotelImage.fromJson(e))
        .toList();
    created = json['created'];
    _id = json['_id'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hotelId'] = hotelId;
    _data['hotelName'] = hotelName;
    _data['hotelDiscription'] = hotelDiscription;
    _data['casinoId'] = casinoId;
    _data['hotelImage'] = hotelImage.map((e) => e.toJson()).toList();
    _data['created'] = created;
    _data['_id'] = _id;
    _data['__v'] = _V;
    return _data;
  }
}

class HotelImage {
  HotelImage({
    required this.picVersion,
    required this.picId,
    //required this._id,
  });
  late final String picVersion;
  late final String picId;
  late final String _id;

  HotelImage.fromJson(Map<String, dynamic> json) {
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
