class StaticPageResponse {
  StaticPageResponse({
    required this.status,
    required this.message,
    required this.staticPageData,
  });
  late final String status;
  late final String message;
  late final List<StaticPageData> staticPageData;

  StaticPageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    staticPageData = List.from(json['staticPageData'])
        .map((e) => StaticPageData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['staticPageData'] = staticPageData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class StaticPageData {
  StaticPageData({
    //  required this._id,
    required this.staticPageId,
    required this.termAndCondition,
    required this.privacyPolicy,
    required this.aboutUs,
    required this.hygienReport,
    required this.createdDate,
    //   required this._V,
  });
  late final String _id;
  late final String staticPageId;
  late final String termAndCondition;
  late final String privacyPolicy;
  late final String aboutUs;
  late final List<HygienReport> hygienReport;
  late final String createdDate;
  late final int _V;

  StaticPageData.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    staticPageId = json['staticPageId'];
    termAndCondition = json['termAndCondition'];
    privacyPolicy = json['privacyPolicy'];
    aboutUs = json['aboutUs'];
    hygienReport = List.from(json['hygienReport'])
        .map((e) => HygienReport.fromJson(e))
        .toList();
    createdDate = json['created_date'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['staticPageId'] = staticPageId;
    _data['termAndCondition'] = termAndCondition;
    _data['privacyPolicy'] = privacyPolicy;
    _data['aboutUs'] = aboutUs;
    _data['hygienReport'] = hygienReport.map((e) => e.toJson()).toList();
    _data['created_date'] = createdDate;
    _data['__v'] = _V;
    return _data;
  }
}

class HygienReport {
  HygienReport({
    required this.title,
    required this.discription,
    //  required this._id,
  });
  late final String title;
  late final String discription;
  late final String _id;

  HygienReport.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    discription = json['discription'];
    _id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['discription'] = discription;
    _data['_id'] = _id;
    return _data;
  }
}
