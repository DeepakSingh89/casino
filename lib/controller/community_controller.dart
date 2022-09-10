import 'dart:developer';
import 'dart:io';

import 'package:casino/api_base_helper/api_base_helper.dart';
import 'package:casino/model/add_casino_forum_response.dart';
import 'package:casino/model/add_comment_to_forum_response.dart';
import 'package:casino/model/casino_forum_response.dart';
import 'package:casino/model/forum_by_id.dart';
import 'package:casino/model/like_dis_like_community.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();
  var isLoading = false.obs;
  var isForumSubmit = false.obs;
  var isLoadingId = false.obs;

  List<Forums> forums = List<Forums>.empty().obs;
  List<Data> forumsDetails = List<Data>.empty().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    print('onInit called');
    getCoummunity();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('AfteronReady called');
  }

  @override
  void onClose() {
    //mobileTextController?.dispose();
    super.onClose();
    print('onClose called');
  }

  void getCoummunity() async {
    isLoading.value = true;
    try {
      final response = await _helper.get("casinoForum/getAllFourms");
      CasinoForumResponse casinoForumResponse =
          CasinoForumResponse.fromJson(response);
      if (casinoForumResponse.status == "success") {
        forums = casinoForumResponse.forums.reversed.toList();
        isLoading.value = false;
      } else {
        if (casinoForumResponse.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        print('e :  {$casinoForumResponse.message}');

        Utility.showError(casinoForumResponse.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoading.value = false;
    }
  }

  void getCoummunityById(String casinoForumId) async {
    isLoadingId.value = true;
    try {
      dynamic body = {
        'casinoForumId': casinoForumId,
      };
      forumsDetails = List<Data>.empty();
      final response =
          await _helper.post("casinoForum/getForumDetailsById", body);
      ForumById forumById = ForumById.fromJson(response);
      if (forumById.status == "success") {
        forumsDetails = forumById.data.reversed.toList();
        isLoadingId.value = false;
      } else {
        if (forumById.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        print('e :  {$forumById.message}');

        Utility.showError(forumById.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingId.value = false;
    }
  }

  Future<bool> addCRTForum(
      String forumName, String forumDetail, List<File> imagesPaths) async {
    isForumSubmit.value = true;

    try {
      Map<String, String> body = Map<String, String>();
      body['casinoForumName'] = forumName;
      body['casinoForumDiscription'] = forumDetail;
      body['userId'] = Utility.getUserID();
      body['userName'] = Utility.getUserName();
      body['userPicVersion'] = Utility.getUserProfilePicVersion();
      body['userPicId'] = Utility.getUserProfilePicID();

      final response = await _helper.multipartRequestDio(
          "casinoForum/create-forum", body, imagesPaths);
      log("response ${response}");
      AddCasinoForumResponse addCasinoForumResponse =
          AddCasinoForumResponse.fromJson(response);
      isForumSubmit.value = false;
      if (addCasinoForumResponse.status == "success") {
        return true;
      } else {
        if (addCasinoForumResponse.message == "Token_Expired ") {
          Utility.logout();
          return false;
        }
        print('e :  {$addCasinoForumResponse.message}');

        Utility.showError(addCasinoForumResponse.message);
      }

      return false;
    } catch (e, s) {
      print('e :  {$s}');
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isForumSubmit.value = false;
    }
    return false;
  }

  Future<bool> removeLike(String casinoForumId, String userID) async {
    dynamic body = {'casinoForumId': casinoForumId, 'userId': userID};
    try {
      final response =
          await _helper.post("casinoForum/removeLikeToForum", (body));
      final likeDisLikeCommunity = LikeDisLikeCommunity.fromJson(response);
      if (likeDisLikeCommunity.status == "success") {
        return true;
      } else {
        Utility.showError(likeDisLikeCommunity.message);
        print("Error : ${likeDisLikeCommunity.message}");
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
    }
    return false;
  }

  Future<bool> addLike(String casinoForumId, String userID) async {
    dynamic body = {'casinoForumId': casinoForumId, 'userId': userID};
    try {
      final response = await _helper.post("casinoForum/addLikeToForum", (body));
      final likeDisLikeCommunity = LikeDisLikeCommunity.fromJson(response);
      if (likeDisLikeCommunity.status == "success") {
        return true;
      } else {
        Utility.showError(likeDisLikeCommunity.message);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
    }
    return false;
  }

  Future<bool> addComment(String casinoForumId, String userID, String forumData,
      String userProfilePicID, String userProfilePicVersion) async {
    dynamic body = {
      'casinoForumId': casinoForumId,
      'userId': userID,
      'comment': forumData,
      'userPicId': userProfilePicID,
      'userPicVersion': userProfilePicVersion,
    };
    try {
      final response =
          await _helper.post("casinoForum/addCommentToForum", (body));
      final addCommentToForumResponse =
          AddCommentToForumResponse.fromJson(response);
      if (addCommentToForumResponse.status == "success") {
        // getCoummunity();
        // Get.back();
        getCoummunityById(casinoForumId);
        Utility.showInfo(addCommentToForumResponse.message);
        return true;
      } else {
        Utility.showError(addCommentToForumResponse.message);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      Utility.showError(Constant.SERVER_ERROR);
      return false;
    }
    return false;
  }
}
