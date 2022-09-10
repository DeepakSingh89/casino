class GoogleNearby {
  late final List<Results> results;
  late final String status;

  GoogleNearby({required this.results, required this.status});

  GoogleNearby.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Results {
  // late final String businessStatus;
  late final Geometry geometry;
  // late final String icon;
  // late final String iconBackgroundColor;
  // late final String iconMaskBaseUri;
  late final String name;
  // late final OpeningHours openingHours;
  late final List<Photos> photos;
  // late final String placeId;
  //late final PlusCode plusCode;
  //late final double rating;
  //late final String reference;
  //late final String scope;
  //late final List<String> types;
  //late final int userRatingsTotal;
  //late final String vicinity;
  //late final bool permanentlyClosed;

  Results({
    //required this.businessStatus,
    required this.geometry,
    //required this.icon,
    //required this.iconBackgroundColor,
    //required this.iconMaskBaseUri,
    required this.name,
    //required this.openingHours,
    required this.photos,
    //required this.placeId,
    //required this.plusCode,
    //required this.rating,
    //required this.reference,
    //required this.scope,
    //required this.types,
    //required this.userRatingsTotal,
    //required this.vicinity,
    //required this.permanentlyClosed
  });

  Results.fromJson(Map<String, dynamic> json) {
    // businessStatus = json['business_status'];
    geometry = (json['geometry'] != null
        ? Geometry.fromJson(json['geometry'])
        : null)!;
    //icon = json['icon'];
    //iconBackgroundColor = json['icon_background_color'];
//iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    // openingHours = (json['opening_hours'] != null
    //     ? OpeningHours.fromJson(json['opening_hours'])
    //     : null)!;
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    } else {
      photos = [];
      photos.add(Photos(
          height: 0, width: 0, photoReference: "", htmlAttributions: []));
    }
    //placeId = json['place_id'];
    // plusCode = (json['plus_code'] != null
    //     ? PlusCode.fromJson(json['plus_code'])
    //     : null)!;
    //rating = json['rating'];
    //reference = json['reference'];
    //scope = json['scope'];
    // types = json['types'].cast<String>();
    // userRatingsTotal = json['user_ratings_total'];
    //vicinity = json['vicinity'];
    //permanentlyClosed = json['permanently_closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['business_status'] = this.businessStatus;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    // data['icon'] = this.icon;
    // data['icon_background_color'] = this.iconBackgroundColor;
    // data['icon_mask_base_uri'] = this.iconMaskBaseUri;
    data['name'] = this.name;
    // if (this.openingHours != null) {
    //   data['opening_hours'] = this.openingHours.toJson();
    // }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    //data['place_id'] = this.placeId;
    // if (this.plusCode != null) {
    //   data['plus_code'] = this.plusCode.toJson();
    // }
    //data['rating'] = this.rating;
    //data['reference'] = this.reference;
    //data['scope'] = this.scope;
    //data['types'] = this.types;
    //data['user_ratings_total'] = this.userRatingsTotal;
    //data['vicinity'] = this.vicinity;
    //data['permanently_closed'] = this.permanentlyClosed;
    return data;
  }
}

class Geometry {
  late final Location location;

  Geometry({
    required this.location,
  });

  Geometry.fromJson(Map<String, dynamic> json) {
    location = (json['location'] != null
        ? Location.fromJson(json['location'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Location {
  late final double lat;
  late final double lng;

  Location({required this.lat, required this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class OpeningHours {
  late final bool openNow;

  OpeningHours({required this.openNow});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['open_now'] = this.openNow;
    return data;
  }
}

class Photos {
  late final int height;
  late final List<String> htmlAttributions;
  late final String photoReference;
  late final int width;

  Photos(
      {required this.height,
      required this.htmlAttributions,
      required this.photoReference,
      required this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}

class PlusCode {
  late final String compoundCode;
  late final String globalCode;

  PlusCode({required this.compoundCode, required this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}


/*class GoogleNearby {
  late final String name;
  late final List<Photos> photos;
  late final Geometry geometry;

  GoogleNearby({
    required this.name,
    required this.photos,
    required this.geometry,
  });

  GoogleNearby.fromJson(Map<String, dynamic> json) {
    geometry = (json['geometry'] != null
        ? Geometry.fromJson(json['geometry'])
        : null)!;
    name = json['name'];
    if (json['photos'] != null) {
      photos = List<Photos>.empty();
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;

    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Photos {
  late final dynamic height;
  late final List<String> htmlAttributions;
  late final String photoReference;
  late final dynamic width;

  Photos(
      {required this.height,
      required this.htmlAttributions,
      required this.photoReference,
      required this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}

class Geometry {
  late final Location location;

  Geometry({
    required this.location,
  });

  Geometry.fromJson(Map<String, dynamic> json) {
    location = (json['location'] != null
        ? Location.fromJson(json['location'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }

    return data;
  }
}

class Location {
  dynamic lat;
  dynamic lng;

  Location({required this.lat, required this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}*/
