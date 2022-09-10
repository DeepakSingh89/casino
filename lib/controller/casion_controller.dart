import 'dart:developer';

import 'package:casino/api_base_helper/api_base_helper.dart';
import 'package:casino/model/favorite_casions.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/model/game_min_max.dart';
import 'package:casino/model/general_response.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:get/get.dart';

class CasionController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();
  var isLoadingCasionDetails = false.obs;
  var isLoadingCasionReview = false.obs;
  var isLoadingFavCasionReview = false.obs;
  var isCasionFavt = false.obs;

  var isCasionMinMax = false.obs;

  late List<CasinoDetails> casinoDetails = List<CasinoDetails>.empty().obs;
  late List<FavouriteList> favouriteList = List<FavouriteList>.empty().obs;
  late List<Data> maxMinDatas = List<Data>.empty().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    print('onInit called');
    isCasionFavt.value = false;
    super.onInit();
  }

  void getCasinoDetails(String casionId) async {
    print(' CasionController getCasinoDetails called() casionId : $casionId');
    isLoadingCasionDetails.value = true;

    dynamic body = {
      'casinoId': casionId,
    };

    try {
      final response = await _helper.post("casino/find-casinoBy-Id", (body));
      log(" CasionController response ${response}");
      FindCasinoById findCasinoById = FindCasinoById.fromJson(response);

      if (findCasinoById.status == "success") {
        casinoDetails = findCasinoById.casinoDetails;
        isLoadingCasionDetails.value = false;
      } else {
        if (findCasinoById.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        print('e :  {$findCasinoById.message}');
        Utility.showError(findCasinoById.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoadingCasionDetails.value = false;
    }
  }

  void getFavoriteCasinoDetails(String userId) async {
    print('getFavoriteCasinoDetails called() userId : $userId');
    isLoadingFavCasionReview.value = true;
    try {
      final response = await _helper.get("user/getFavouriteList/$userId");

      FavoriteCasions favoriteCasions = FavoriteCasions.fromJson(response);

      if (favoriteCasions.status == "success") {
        favouriteList = favoriteCasions.favouriteList;
        isLoadingFavCasionReview.value = false;
      } else {
        if (favoriteCasions.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        print('e :  {$favoriteCasions.message}');
        Utility.showError(favoriteCasions.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoadingFavCasionReview.value = false;
    }
  }

  void addCasionToFav(
      String userId,
      String casinoId,
      String casinoName,
      String casinoDiscription,
      String picVersion,
      String picId,
      double lat,
      double long) async {
    dynamic body = {
      'userId': userId,
      'casinoId': casinoId,
      'casinoName': casinoName,
      'casinoDiscription': casinoDiscription,
      'picVersion': picVersion,
      'picId': picId,
      'lat': lat.toString(),
      'long': long.toString(),
    };

    try {
      Utility.showInfo("Please wait ..");
      final response = await _helper.post("user/addCasinoFavourite", (body));
      GeneralResponse generalResponse = GeneralResponse.fromJson(response);
      if (generalResponse.status == "success") {
        Utility.showInfo(generalResponse.message);
      } else {
        if (generalResponse.message == "Token_Expired ") {
          Utility.logout();
          return;
        }

        Utility.showError(generalResponse.message);
        print('e :  {$generalResponse.message}');
      }
    } catch (e, s) {
      print('e :  {$s}');
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
    }
  }

  void  removeCasinoFavourite(String userID, String casinoId) async {
    dynamic body = {
      'userId': userID,
      'casinoId': casinoId,
    };

    try {
      Utility.showInfo("Please wait ..");
      final response = await _helper.post("user/removeCasinoFavourite", (body));
      GeneralResponse generalResponse = GeneralResponse.fromJson(response);
      if (generalResponse.status == "success") {
        Utility.showInfo(generalResponse.message);
      } else {
        if (generalResponse.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        print('e :  {$generalResponse.message}');
        Utility.showError(generalResponse.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
    }
  }

  void getMinmaxCasinoId(String casinoId) async {
    dynamic body = {
      'casinoId': casinoId,
    };

    try {
      isCasionMinMax.value = true;
      //Utility.showInfo("Please wait ..");
      final response = await _helper.post("casino/get-minmax-casinoId", (body));
      GameMinMax gameMinMax = GameMinMax.fromJson(response);
      if (gameMinMax.status == "success") {
        maxMinDatas = gameMinMax.data;
      } else {
        if (gameMinMax.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        print('e :  {$gameMinMax.message}');
        Utility.showError(gameMinMax.message);
      }

      isCasionMinMax.value = false;
    } catch (e, s) {
      print('e :  {$s}');
      isCasionMinMax.value = false;
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
    }
  }
}
