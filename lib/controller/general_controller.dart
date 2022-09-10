import 'dart:developer';

import 'package:casino/api_base_helper/api_base_helper.dart';
import 'package:casino/model/badge_response.dart';
import 'package:casino/model/static_page_response.dart';
import 'package:casino/model/user_profile_pic_upload_response.dart';
import 'package:casino/model/verify_otp_response.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:get/get.dart';
import 'dart:ui';

class GeneralController extends GetxController {
  var showCovid = false.obs;
  final ApiBaseHelper _helper = ApiBaseHelper();
  var staticPageData = List<StaticPageData>.empty().obs;
  var isLoading = false.obs;
  var isLoadingGame = false.obs;
  var isLoadingBadge = false.obs;

  late List<Badge> badges = List<Badge>.empty().obs;

  late List<Badge> originalBadges = List<Badge>.empty().obs;

  void changeLanguage(String lang) {
    var parm1 = 'en';
    var parm2 = 'US';

    if (lang == 'Spanish' || lang == 'sp') {
      parm1 = 'es';
      parm2 = 'ES';
    }
    var locale = Locale(parm1, parm2);
    Get.updateLocale(locale);

    Utility.updateLang(lang);
  }

  void updateProfilePic(String userId, String image) async {
    isLoading.value = true;

    dynamic body = {'userId': userId, 'image': 'data:image/png;base64,$image'};
    try {
      final response = await _helper.post("user/update-profile-image", (body));
      final userProfilePicUploadResponse =
          UserProfilePicUploadResponse.fromJson(response);
      isLoading.value = false;
      if (userProfilePicUploadResponse.status == "success") {
        Utility.updateUserProfile(
            userProfilePicUploadResponse.userDetails.picId,
            userProfilePicUploadResponse.userDetails.picVersion);
        Utility.showInfo(userProfilePicUploadResponse.message);
      } else {
        Utility.showError(userProfilePicUploadResponse.message);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoading.value = false;
    }
  }

  void updateLanguageByUser(String userId, String language) async {
    isLoading.value = true;

    dynamic body = {'userId': userId, 'language': language};
    try {
      final response = await _helper.post("user/updateLanguageByUser", (body));
      final userProfilePicUploadResponse = VerifyOtpResponse.fromJson(response);
      isLoading.value = false;
      if (userProfilePicUploadResponse.status == "success") {
        Utility.showInfo(userProfilePicUploadResponse.message);
      } else {
        Utility.showError(userProfilePicUploadResponse.message);
        print("Error : ${userProfilePicUploadResponse.message}");
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoading.value = false;
    }
  }

  void getStaticPage() async {
    isLoading.value = true;
    try {
      final response = await _helper.get(
        "badgeManagement/find-staticPageData",
      );
      final staticPageResponse = StaticPageResponse.fromJson(response);
      isLoading.value = false;
      if (staticPageResponse.status == "success") {
        staticPageData.value = staticPageResponse.staticPageData;
      } else {
        Utility.showError(staticPageResponse.message);
        print("Error : ${staticPageResponse.message}");
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoading.value = false;
    }
  }

  void gameUpdateByUser(
      casinoId, gameModeId, maxVal, minVal, String userID) async {
    log("gameUpdateByUser()  gameModeId $gameModeId : maxVal $maxVal , minVal $minVal  ");
    isLoading.value = true;
    dynamic body = {
      'casinoId': casinoId,
      'gameModeId': gameModeId,
      'minBetSize': minVal,
      'maxBetSize': maxVal,
      'modifidById': userID,
    };
    try {
      final response = await _helper.post("casino/game-updateBy-user", (body));
      final userProfilePicUploadResponse = VerifyOtpResponse.fromJson(response);
      log(" userProfilePicUploadResponse ${userProfilePicUploadResponse}");
      isLoading.value = false;
      if (userProfilePicUploadResponse.status == "success") {
        Get.offNamedUntil(MyRouter.myBottomNavScreen, (route) => false);
      } else {
        Utility.showError(userProfilePicUploadResponse.message);
        print("Error : ${userProfilePicUploadResponse.message}");
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoading.value = false;
    }
  }

  getBadge(bool isCompleteBadgeRequired) async {
    try {
      isLoadingBadge.value = true;
      final response = await _helper.get(
        "badgeManagement/find-badge",
      );
      final badgeResponse = BadgeResponse.fromJson(response);
      isLoadingBadge.value = false;
      if (badgeResponse.status == "success") {
        List<Badge> localBdge = [];
        originalBadges = badgeResponse.badge;
        print(" getBadge ${badgeResponse.badge.length} ");
        for (var element in badgeResponse.badge) {
          int badgePoint = int.parse(element.badgePoint);

          if (Utility.getUserRateNumber() >= badgePoint) {
            // if (!isCompleteBadgeRequired) {
            //   Utility.saveComingBadge(element ,  );
            // }

            localBdge.add(
              Badge(
                badgeId: element.badgeId,
                badgeName: element.badgeName,
                badgePoint: element.badgePoint,
                badgePicId: element.badgePicId,
                badgePicVersion: element.badgePicVersion,
                badgeDiscription: element.badgeDiscription,
                createdDate: element.createdDate,
              ),
            );
          }
        }
        badges = localBdge;
      } else {
        Utility.showError(badgeResponse.message);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoadingBadge.value = false;
    }
  }
}
