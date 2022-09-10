class GameMinMax {
  GameMinMax({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final List<Data> data;

  GameMinMax.fromJson(Map<String, dynamic> json) {
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
    //  required this._id,
    required this.minmaxId,
    required this.casinoId,
    required this.gameName,
    required this.minBetSize,
    required this.maxBetSize,
    //required this._V,
  });
  //late final String _id;
  late final String minmaxId;
  late final String casinoId;
  late final String gameName;
  late final double minBetSize;
  late final double maxBetSize;
  //late final int _V;

  Data.fromJson(Map<String, dynamic> json) {
    // _id = json['_id'];
    minmaxId = json['minmaxId'];
    casinoId = json['casinoId'];
    gameName = json['gameName'];
    //minBetSize = json['minBetSize'];
    //maxBetSize = json['maxBetSize'];

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

    //_V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['_id'] = _id;
    _data['minmaxId'] = minmaxId;
    _data['casinoId'] = casinoId;
    _data['gameName'] = gameName;
    _data['minBetSize'] = minBetSize;
    _data['maxBetSize'] = maxBetSize;
    //_data['__v'] = _V;
    return _data;
  }
}
