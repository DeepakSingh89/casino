class FindCasinoById {
  FindCasinoById({
    required this.status,
    required this.message,
    required this.casinoDetails,
  });
  late final String status;
  late final String message;
  late final List<CasinoDetails> casinoDetails;

  FindCasinoById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    casinoDetails = List.from(json['casinoDetails'])
        .map((e) => CasinoDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['casinoDetails'] = casinoDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CasinoDetails {
  CasinoDetails({
    //required this._id,
    required this.casinoId,
    required this.casinoName,
    required this.casinoDiscription,
    required this.picVersion,
    required this.picId,
    required this.location,
    required this.rating,
    required this.noOfRating,
    required this.gameMode,
    required this.created,
    //required this._V,
    required this.address,
    required this.updateDate,
  });
  late final String _id;
  late final String casinoId;
  late final String casinoName;
  late final String casinoDiscription;
  late final String picVersion;
  late final String picId;
  late final List<double> location;
  late final double rating;
  late final int noOfRating;
  late final List<GameMode> gameMode;
  late final String created;
  late final int _V;
  late final String address;
  late final String updateDate;

  CasinoDetails.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    casinoId = json['casinoId'];
    casinoName = json['casinoName'];
    casinoDiscription = json['casinoDiscription'];
    picVersion = json['picVersion'];
    picId = json['picId'];
    location = List.castFrom<dynamic, double>(json['location']);

    try {
      if (json['rating'] == 0) {
        rating = 0.0;
      } else if (json['rating'] is double) {
        rating = json['rating'];
      } else {
        rating = double.parse(json['rating']);
      }
    } catch (e, s) {
      print("FindCasionId ${e.toString()}");
      rating = 0.0;
    }

    noOfRating = json['noOfRating'];
    gameMode =
        List.from(json['gameMode']).map((e) => GameMode.fromJson(e)).toList();
    created = json['created'];
    _V = json['__v'];
    address = json['address'];

    if (json['update_date'] != null) {
      updateDate = json['update_date'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['casinoId'] = casinoId;
    _data['casinoName'] = casinoName;
    _data['casinoDiscription'] = casinoDiscription;
    _data['picVersion'] = picVersion;
    _data['picId'] = picId;
    _data['location'] = location;
    //_data['rating'] = rating;
    if (_data['rating'] != 0)
      _data['rating'] = rating;
    else
      _data['rating'] = 0;
    _data['noOfRating'] = noOfRating;
    _data['gameMode'] = gameMode.map((e) => e.toJson()).toList();
    _data['created'] = created;
    _data['__v'] = _V;
    _data['address'] = address;

    if (_data['update_date'] != null) {
      _data['update_date'] = updateDate;
    }

    return _data;
  }
}

class GameMode {
  GameMode({
    required this.gameName,
    required this.subGameName,
    required this.gameActive,
    required this.minBetSize,
    required this.maxBetSize,
    required this.createdDate,
    this.modifidDate,
    required this.modifidBy,
    required this.modifidById,
    required this.id,
  });
  late final String gameName;
  late final String subGameName;
  late final bool gameActive;
  late final double minBetSize;
  late final double maxBetSize;
  late final String createdDate;
  late final Null modifidDate;
  late final String modifidBy;
  late final String modifidById;
  late final String id;

  GameMode.fromJson(Map<String, dynamic> json) {
    gameName = json['gameName'];
    subGameName = json['subGameName'];
    gameActive = json['gameActive'];
    // minBetSize = json['minBetSize'];
    // maxBetSize = json['maxBetSize'];

    try {
      if (json['minBetSize'] is int) {
        minBetSize = json['minBetSize'].toDouble();
      } else if (json['minBetSize'] is double) {
        minBetSize = json['minBetSize'];
      } else {
        minBetSize = double.parse(json['minBetSize']);
      }
    } catch (e, s) {
      print("FindCasionId ${e.toString()}");
      minBetSize = 0.0;
    }

    // minBetSize = json['minBetSize'];
    //maxBetSize = json['maxBetSize'];

    try {
      if (json['maxBetSize'] is int) {
        maxBetSize = json['maxBetSize'].toDouble();
      } else if (json['maxBetSize'] is double) {
        maxBetSize = json['maxBetSize'];
      } else {
        maxBetSize = double.parse(json['maxBetSize']);
      }
    } catch (e, s) {
      print("FindCasionId ${e.toString()}");
      maxBetSize = 0.0;
    }

    createdDate = json['createdDate'];
    modifidDate = null;
    modifidBy = json['modifidBy'];
    modifidById = json['modifidById'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gameName'] = gameName;
    _data['subGameName'] = subGameName;
    _data['gameActive'] = gameActive;
    _data['minBetSize'] = minBetSize;
    _data['maxBetSize'] = maxBetSize;
    _data['createdDate'] = createdDate;
    _data['modifidDate'] = modifidDate;
    _data['modifidBy'] = modifidBy;
    _data['modifidById'] = modifidById;
    _data['_id'] = id;
    return _data;
  }
}
