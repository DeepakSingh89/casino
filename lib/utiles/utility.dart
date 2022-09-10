// ignore_for_file: void_checks

import 'dart:convert';
import 'package:casino/model/badge_response.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';
import 'package:casino/controller/general_controller.dart';
import 'package:casino/model/find_casino.dart';
import 'package:casino/model/google_nearby.dart';
import 'package:casino/model/user_login.dart';
import 'package:casino/ui/screens/login_screen.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class Utility {
  static loadSaveDataToCache() {
    try {
      final getStorage = GetStorage();

      if (getStorage.hasData(Constant.USER_INFO)) {
        MySingleton.shared.user =
            UserLogin.fromJson(getStorage.read(Constant.USER_INFO)).user;
      }

      MySingleton.shared.userId = getStorage.hasData(Constant.USER_ID)
          ? getStorage.read(Constant.USER_ID)
          : "";
      MySingleton.shared.username = getStorage.hasData(Constant.USER_NAME)
          ? getStorage.read(Constant.USER_NAME)
          : "";

      MySingleton.shared.profilePicURL =
          getStorage.hasData(Constant.USER_PROFILE_PIC_URL)
              ? getStorage.read(Constant.USER_PROFILE_PIC_URL)
              : "";
      MySingleton.shared.isLogin =
          getStorage.hasData(Constant.USER_LOGIN_STATUS)
              ? getStorage.read(Constant.USER_LOGIN_STATUS)
              : false;
    } catch (e) {
      e.printError();
    }
  }

  static bool isLoginRequired() {
    final getStorage = GetStorage();
    return getStorage.hasData(Constant.USER_LOGIN_STATUS)
        ? getStorage.read(Constant.USER_LOGIN_STATUS)
        : false;
  }

  static String getEmailAddress() {
    final getStorage = GetStorage();
    return getStorage.read(Constant.USER_EMAIL);
  }

  static String getUserID() {
    if (MySingleton.shared.userId.isEmpty) {
      final getStorage = GetStorage();
      MySingleton.shared.userId = getStorage.hasData(Constant.USER_ID)
          ? getStorage.read(Constant.USER_ID)
          : "";
    }
    return MySingleton.shared.userId;
  }

  static void updateUserProfile(String picId, String picVersion) {
    final getStorage = GetStorage();
    getStorage.write(Constant.USER_PROFILE_PIC_ID, picId);
    getStorage.write(Constant.USER_PROFILE_PIC_VERSION, picVersion);
    MySingleton.shared.profilePicURL = "${picVersion}/${picId}";
  }

  static String getUserName() {
    if (MySingleton.shared.username.isEmpty) {
      final getStorage = GetStorage();
      MySingleton.shared.username = getStorage.hasData(Constant.USER_NAME)
          ? getStorage.read(Constant.USER_NAME)
          : "";
    }
    return MySingleton.shared.username;
  }

  static String getUserProfile() {
    if (MySingleton.shared.profilePicURL.isEmpty) {
      final getStorage = GetStorage();
      MySingleton.shared.profilePicURL =
          getStorage.hasData(Constant.USER_PROFILE_PIC_URL)
              ? getStorage.read(Constant.USER_PROFILE_PIC_URL)
              : "";
    }
    return MySingleton.shared.profilePicURL;
  }

  static String getUserProfilePicVersion() {
    final getStorage = GetStorage();
    return getStorage.read(Constant.USER_PROFILE_PIC_VERSION);
  }

  static String getUserProfilePicID() {
    final getStorage = GetStorage();
    return getStorage.read(Constant.USER_PROFILE_PIC_ID);
  }

  static int getUserRateNumber() {
    final getStorage = GetStorage();
    if (getStorage.hasData(Constant.USER_RATING)) {
      return getStorage.read(Constant.USER_RATING);
    }

    return 0;
  }

  static double getUserRate() {
    final getStorage = GetStorage();
    if (getStorage.hasData(Constant.USER_RATING)) {
      int noOfReview = getStorage.read(Constant.USER_RATING);
      log("noOfReview ${noOfReview}");
      return noOfReview / 100;
    }

    return 0;
  }

  static void updateUserRate(int noReview) {
    final getStorage = GetStorage();
    getStorage.write(Constant.USER_RATING, noReview);
    MySingleton.shared.userRating = noReview;
  }

  static User getUser() {
    try {
      print("Utility username ${MySingleton.shared.user.username}");
      if (MySingleton.shared.user.username == "") {
        print("Utility parsing user json ");
        final getStorage = GetStorage();
        var userInfo = getStorage.read(Constant.USER_INFO);
        UserLogin userLogin = UserLogin.fromJson(userInfo);
        MySingleton.shared.user = userLogin.user;
      }
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }
    return MySingleton.shared.user;
  }

  static String getUserLang() {
    try {
      final getStorage = GetStorage();
      var userLang = getStorage.hasData(Constant.USER_LANG)
          ? getStorage.read(Constant.USER_LANG)
          : "English";
      MySingleton.shared.userLang = userLang;
      return userLang;
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }
    return MySingleton.shared.userLang;
  }

  static String getAdsImageURL() {
    String imageURl = "";
    try {
      final getStorage = GetStorage();
      var imageURL = getStorage.read(Constant.ADS_IMAGE_URL);
      bool subs = getStorage.read(Constant.SUBSCRIPTION);
      if (!subs) {
        return "${Constant.imageURL}${imageURL}";
      }
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }
    return imageURl;
  }

  static String getAdsActionUrl() {
    String imageURl = "";
    try {
      final getStorage = GetStorage();
      return getStorage.read(Constant.ADS_IMAGE_ACTION_URL);
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }
    return imageURl;
  }

  static bool isUserSubscription() {
    var isUserSubscription = false;
    try {
      final getStorage = GetStorage();
      isUserSubscription = getStorage.read(Constant.SUBSCRIPTION);
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }

    return isUserSubscription;
  }

  // static saveUserInfoSignup(SignupResponse.User user, String JWTToken) {
  //   final getStorage = GetStorage();
  //   getStorage.write(Constant.USER_ID, user.userId);
  //   getStorage.write(Constant.USER_NAME, user.username);
  //   getStorage.write(Constant.USER_EMAIL, user.email);
  //   getStorage.write(
  //       Constant.USER_PROFILE_PIC_URL, "${user.picVersion}/${user.picId}");
  //   getStorage.write(Constant.USER_LOGIN_STATUS, true);
  //   getStorage.write(Constant.USER_DATA, jsonEncode(user));

  //   // Singleton
  //   MySingleton.shared.isLogin = true;
  //   MySingleton.shared.userId = user.userId;
  //   MySingleton.shared.username = user.username;
  //   MySingleton.shared.profilePicURL = "${user.picVersion}/${user.picId}";
  //   MySingleton.shared.userData = jsonEncode(user);
  //   storeJWT(JWTToken);
  // }

  static saveUserInfoLogin(
    User user,
    String JWTToken,
    response,
    List<Ads> ads,
  ) {
    try {
      storeJWT(JWTToken);
      final getStorage = GetStorage();

      getStorage.write(Constant.USER_ID, user.userId);

      getStorage.write(Constant.USER_NAME, user.username);

      getStorage.write(Constant.USER_EMAIL, user.email);

      getStorage.write(
          Constant.USER_PROFILE_PIC_URL, "${user.picVersion}/${user.picId}");

      getStorage.write(Constant.USER_LOGIN_STATUS, true);

      getStorage.write(Constant.USER_RATING, user.noOfReviews);

      getStorage.write(Constant.USER_INFO, response);
      getStorage.write(Constant.SUBSCRIPTION, user.subscription);

      getStorage.write(Constant.USER_PROFILE_PIC_VERSION, user.picVersion);
      getStorage.write(Constant.USER_PROFILE_PIC_ID, user.picId);

      getStorage.write(Constant.USER_LANG, user.language);

      // Singleton
      MySingleton.shared.isLogin = true;

      MySingleton.shared.userId = user.userId;

      MySingleton.shared.username = user.username;

      MySingleton.shared.profilePicURL = "${user.picVersion}/${user.picId}";

      MySingleton.shared.userRating = user.noOfReviews;

      MySingleton.shared.user = user;
      MySingleton.shared.userSubscription = user.subscription;

      MySingleton.shared.userLang = user.language;

      // ads
      if (ads.isNotEmpty) {
        getStorage.write(
            Constant.ADS_IMAGE_URL, "${ads[0].picVersion}/${ads[0].picId}");

        getStorage.write(Constant.ADS_IMAGE_ACTION_URL, ads[0].adsUrl);
      }
    } catch (e) {
      e.printError();
    }
  }

  static Future<String> get jwtOrEmpty async {
    const storage = const FlutterSecureStorage();
    var jwt = await storage.read(key: Constant.JWT);
    if (jwt == null) return "";
    return jwt;
  }

  static void storeJWT(String jwt_) async {
    //print("storeJWT ${jwt_}");
    final storage = FlutterSecureStorage();
    await storage.write(key: Constant.JWT, value: jwt_);
  }

  static logout() async {
    MySingleton.shared.isLogin = false;

    MySingleton.shared.userId = "";

    MySingleton.shared.username = "";

    MySingleton.shared.profilePicURL = "";

    MySingleton.shared.userRating = 0;

    // MySingleton.shared.user = "";
    MySingleton.shared.userSubscription = false;

    MySingleton.shared.userLang = "";

    final storage = const FlutterSecureStorage();
    storage.delete(key: Constant.JWT);
    final getStorage = GetStorage();
    getStorage.remove(Constant.USER_ID);
    getStorage.remove(Constant.USER_NAME);
    getStorage.remove(Constant.USER_EMAIL);
    getStorage.remove(Constant.USER_PROFILE_PIC_URL);
    getStorage.remove(Constant.USER_LOGIN_STATUS);
    getStorage.remove(Constant.RECENT_CASIONS);
    getStorage.remove(Constant.ADS_IMAGE_ACTION_URL);
    getStorage.remove(Constant.ADS_IMAGE_URL);

    final GeneralController _generalController = Get.find();
    try {
      _generalController.changeLanguage("English");
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }

    Get.offAll(() => const LoginScreen());
  }

  static int getCurrentTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static addRecentCasion(CasinoResult casinoResult) {
    try {
      final getStorage = GetStorage();
      var recentCasion = getStorage.read(Constant.RECENT_CASIONS);

      if (recentCasion == null) {
        var casion_ = [];
        casion_.add(casinoResult);
        var casionData = jsonEncode(casion_);
        getStorage.write(Constant.RECENT_CASIONS, casionData);
      } else {
        List<CasinoResult> storeRecentCasions =
            (json.decode(recentCasion) as List)
                .map((data) => CasinoResult.fromJson(data))
                .toList();

        storeRecentCasions.forEach((element) {
          if (element.casinoId == casinoResult.casinoId) {
            storeRecentCasions.remove(element);
          }
        });
        storeRecentCasions.add(casinoResult);
        getStorage.write(
            Constant.RECENT_CASIONS, jsonEncode(storeRecentCasions));
      }
    } catch (e) {
      e.printError();
    }
  }

  static List<CasinoResult> getRecentCasion() {
    try {
      final getStorage = GetStorage();
      var recentCasion = getStorage.read(Constant.RECENT_CASIONS);
      if (recentCasion == null) {
        return [];
      }
      return (json.decode(recentCasion) as List)
          .map((data) => CasinoResult.fromJson(data))
          .toList();
    } catch (e) {
      e.printError();
    }
    return [];
  }

  static String getDate(String date_) {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      DateTime dateTime = dateFormat.parse(date_);
      // return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
      return "${dateTime.month}/${dateTime.day}/${dateTime.year}";
    } catch (e) {
      e.printError();
    }

    return "00/00/0000";
  }

  static void updateLang(String lan) {
    final getStorage = GetStorage();
    getStorage.write(Constant.USER_LANG, lan);
    MySingleton.shared.userLang = lan;
  }

  static double getDistanceBetween(
      double lat1, double long1, double lat2, double long2) {
    try {
      log("Utility lat1 $lat1 long1 $long1  lat2 $lat2  long2 $long2 ");
      //var dis = Geolocator.distanceBetween(lat1, long1, long2, lat2);
      var dis = Geolocator.distanceBetween(lat1, long1, lat2, long2);
      log("dis ${dis}");
      return (dis * 0.0006213712).toPrecision(3);
    } catch (e) {
      print(e.toString());
    }
    return 10;
  }

  static double getDistanceBetweeninMeter(
      double lat1, double long1, double lat2, double long2) {
    try {
      log("Utility lat1 $lat1 long1 $long1  lat2 $lat2  long2 $long2 ");
      //var dis = Geolocator.distanceBetween(lat1, long1, long2, lat2);
      var dis = Geolocator.distanceBetween(lat1, long1, lat2, long2);
      log("dis ${dis}");
      return dis;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  static Future<Position> getCurrentLatLong() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static double convertIntoMile(int loct) {
    return loct * 1609;
  }

  static String getDay(CasinoDetails casinoDetail) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime today = DateTime.now();
    try {
      if (casinoDetail.updateDate.isEmpty) {
        DateTime dateTime = dateFormat.parse(casinoDetail.created);
        return "${today.day - dateTime.day}";
      }

      DateTime dateTime = dateFormat.parse(casinoDetail.updateDate);

      return "${today.day - dateTime.day}";
    } catch (e) {
      e.printError();
    }
    DateTime dateTime = dateFormat.parse(casinoDetail.created);
    return "${today.day - dateTime.day}";
  }

  static showError(String content) {
    Get.snackbar(
      "",
      content,
      colorText: MyAppTheme.textWhite,
    );
  }

  static String getGoogleImage(Results results) {
    if (results.photos.first.photoReference.isEmpty) {
      return "";
    }
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${results.photos.first.photoReference}&key=${Constant.mapKey}";
  }

  static Future<String> convertLagLongToAddress(
      double lat1, double long1) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat1, long1);
      return placemarks.first.name.toString();
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  static void saveRadius(int radius) {
    try {
      final getStorage = GetStorage();
      getStorage.write(Constant.RADUIS, radius);
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }
  }

  static int getRadius() {
    try {
      final getStorage = GetStorage();
      var dist = getStorage.hasData(Constant.RADUIS)
          ? getStorage.read(Constant.RADUIS)
          : 1;

      return dist;
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }

    return 1;
  }

  static Future<void> launchInBrowser(String url) async {
    print(" launchInBrowser ${url}");
    if (await canLaunch(url)) {
      await launch(url);
    } else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  static void saveComingBadge(Badge element) {
    try {
      if (Utility.getUserRateNumber() == 0) {
        return;
      }
      final getStorage = GetStorage();
      getStorage.write(Constant.USER_BADGE_COUNT,
          Utility.getUserRateNumber() - int.parse(element.badgePoint));
      getStorage.write(Constant.USER_BADGE_NAME, element.badgeName);
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }
  }

  static showInfo(String content) {
    Get.snackbar("", content, colorText: MyAppTheme.textWhite);
  }

  static String getImageUrl(String picId, String picVersion) {
    var url = "${Constant.imageURL}${picVersion}/${picId}";
    print(" url ${url}");
    return url;
  }

  static int getNextBadgeCount(List<Badge> badges) {
    int count = 0;
    print("Utility ${badges.length}");
    for (var element in badges) {
      int badgePoint = int.parse(element.badgePoint);
      int userRate = Utility.getUserRateNumber();

      print(
          "Utility badgePoint ${badgePoint} userRate ${userRate}  ${badges.length} ");
      if (badgePoint > userRate) {
        count = badgePoint - userRate;
        break;
      }
    }
    return count;
  }
}
