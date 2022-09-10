import 'dart:collection';

import 'package:casino/model/user_login.dart';

class MySingleton {
  static final MySingleton _singleton = MySingleton._internal();
  String userId = "";
  String username = "";
  String email = "";
  int mobileNo = 0;
  String password = "";
  String language = "";
  String deviceToken = "";
  String image = "";
  String uploadImage = "";
  String profilePicURL = "";
  String socialMediaProfilePci = "";
  String userInfo = "";
  int userRating = 0;
  bool isLogin = false;
  bool userSubscription = false;
  String userLang = "English";
  User user = User(
      noOfReviews: 0,
      userId: "",
      username: "",
      email: "",
      password: "",
      number: 0,
      picVersion: "",
      picId: "",
      lat: 0.0,
      long: 0.0,
      language: "",
      activeUser: false,
      subscription: false,
      paymentType: "",
      paymentAmount: 0,
      favourite: [],
      deviceToken: "",
      created: "",
      location: [],
      OTP: 0);

  Ads ads = Ads(
    adsId: "",
    picVersion: "",
    picId: "",
    adsUrl: "",
  );

  UserLogin userLogin = UserLogin(
    status: "",
    message: "",
    user: User(
        noOfReviews: 0,
        userId: "",
        username: "",
        email: "",
        password: "",
        number: 0,
        picVersion: "",
        picId: "",
        lat: 0.0,
        long: 0.0,
        language: "",
        activeUser: false,
        subscription: false,
        paymentType: "",
        paymentAmount: 0,
        favourite: [],
        deviceToken: "",
        created: "",
        location: [],
        OTP: 0),
    ads: [],
    token: "",
  );

  String adsImageURL = "";
  HashMap location = HashMap<double, double>();
  HashMap attemptedRecord = HashMap<int, String>();
  HashMap answerColorRecord = HashMap<String, String>();
  factory MySingleton() {
    return _singleton;
  }
  MySingleton._internal();
  static MySingleton get shared => _singleton;
}
