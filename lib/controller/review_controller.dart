import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:casino/api_base_helper/api_base_helper.dart';
import 'package:casino/controller/casion_controller.dart';
import 'package:casino/model/add_casion_review.dart';
import 'package:casino/model/add_hotel.dart';
import 'package:casino/model/add_hotel.dart' as hotel;
import 'package:casino/model/add_hotel_review.dart';
import 'package:casino/model/add_restaurant.dart';
import 'package:casino/model/casino_review_rating_by_casion.dart';
import 'package:casino/model/casino_user_review_rating.dart'
    as CasinoUserReviewRating;
import 'package:casino/model/forum_review_rating_response.dart';
import 'package:casino/model/get_forum_review.dart' as GetForumReview;
import 'package:casino/model/google_nearby.dart';
import 'package:casino/model/hotel_review_response.dart';
import 'package:casino/model/restaurant_review_rating.dart'
    as RestaurantReviewRating;

import 'package:casino/model/restaurant_review_response.dart'
    as RestaurantReviewResponse;

import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  var isLoadingCasionReview = false.obs;
  var isLoadingForumReview = false.obs;

  var isLoadingAddRestaurant = false.obs;
  var isLoadingCasion = false.obs;
  var isLoadingFood = false.obs;
  var isLoadingHotel = false.obs;
  var isLoadingForum = false.obs;

  // var selectedUser = Results(
  //   name: "",
  //   photos: [],
  //   geometry: Geometry(location: Location(lat: 0.0, lng: 0.0)),
  // ).obs ;

  var selectedUser = List<Results>.empty().obs;
  var selectedHotelUser = List<Results>.empty().obs;

  var googleRestaurantNearbyResult = List<Results>.empty().obs;
  var googleHotelNearbyResult = List<Results>.empty().obs;

  var isGoogleRestaurantNearby = false.obs;
  var isGoogleHotelNearbyResult = false.obs;

  var restaurantDetails = RestaurantDetails(
          restaurantId: "",
          restaurantName: "",
          restaurantDiscription: "",
          casinoId: "",
          restaurantImage: [],
          created: "")
      .obs;
  var hotelDetails = hotel.HotelDetails(
    hotelId: "",
    hotelName: "",
    hotelDiscription: "",
    casinoId: "",
    hotelImage: [],
    created: "",
  ).obs;

  var isLoadingFoodReview = false.obs;
  var casinoData = List<CasinoData>.empty().obs;
  List<CasinoUserReviewRating.CasinoData> casinoUserReviewRating =
      List<CasinoUserReviewRating.CasinoData>.empty().obs;

  List<HotelData> hotelData = List<HotelData>.empty().obs;

  List<RestaurantReviewResponse.RestaurantData>
      restaurantReviewResponsehotelData =
      List<RestaurantReviewResponse.RestaurantData>.empty().obs;

  List<GetForumReview.HotelData> hotelDataForumReview =
      List<GetForumReview.HotelData>.empty().obs;

  final ApiBaseHelper _helper = ApiBaseHelper();

  void getCasionReviewCasionDetail(String casionId) async {
    log('getCasionReviewCasionDetail called() casionId : $casionId');
    isLoadingCasionReview.value = true;

    dynamic body = {
      'casinoId': casionId,
    };

    try {
      final response = await _helper.post(
          "casinoReviewRating/get-review-rating-by-casino", (body));
      CasinoReviewRatingByCasion casinoReviewRatingByCasion =
          CasinoReviewRatingByCasion.fromJson(response);
      isLoadingCasionReview.value = false;
      if (casinoReviewRatingByCasion.status == "success") {
        casinoData.value = casinoReviewRatingByCasion.casinoData;
      } else {
        if (casinoReviewRatingByCasion.message == "Token_Expired ") {
          Utility.logout();
          return;
        }

        Utility.showError(casinoReviewRatingByCasion.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoadingCasionReview.value = false;
    }
  }

  void getHotelReviewByCasion(String casionId) async {
    print('getHotelReviewByCasion called() casionId : $casionId');
    isLoadingHotel.value = true;

    dynamic body = {
      'casinoId': casionId,
    };

    try {
      final response = await _helper.post(
          "hotelReviewRating/get-review-rating-by-casino", (body));

      HotelReviewResponse hotelReviewResponse =
          HotelReviewResponse.fromJson(response);
      isLoadingHotel.value = false;
      if (hotelReviewResponse.status == "success") {
        hotelData = hotelReviewResponse.hotelData;
      } else {
        if (hotelReviewResponse.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        Utility.showError(hotelReviewResponse.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoadingHotel.value = false;
    }
  }

  void getFoodReviewByCasion(String casionId) async {
    print('getFoodReviewByCasion called() casionId : $casionId');
    isLoadingFood.value = true;

    dynamic body = {
      'casinoId': casionId,
    };

    try {
      final response = await _helper.post(
          "restaurantReviewRating/get-review-rating-by-casino", (body));
      log("Food response ${response}");
      RestaurantReviewResponse.RestaurantReviewResponse hotelReviewResponse =
          RestaurantReviewResponse.RestaurantReviewResponse.fromJson(response);
      isLoadingFood.value = false;
      if (hotelReviewResponse.status == "success") {
        restaurantReviewResponsehotelData = hotelReviewResponse.restaurantData;
      } else {
        if (hotelReviewResponse.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        Utility.showError(hotelReviewResponse.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingFood.value = false;
    }
  }

  void getCasionReviewByUserId(String userId) async {
    print('getCasionReviewByUserId called() casionId : $userId');
    isLoadingCasion.value = true;

    dynamic body = {
      'userId': userId,
    };

    try {
      final response = await _helper.post(
          "casinoReviewRating/get-review-rating-by-user", (body));
      CasinoUserReviewRating.CasinoUserReviewRating casinoUserReviewRating_ =
          CasinoUserReviewRating.CasinoUserReviewRating.fromJson(response);
      isLoadingCasion.value = false;
      if (casinoUserReviewRating_.status == "success") {
        casinoUserReviewRating = casinoUserReviewRating_.casinoData;
      } else {
        if (casinoUserReviewRating_.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        Utility.showError(casinoUserReviewRating_.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingCasion.value = false;
    }
  }

  Future<bool> addRestaurant(
      String restaurantName,
      String restaurantDiscription,
      String casinoId,
      List<File> images,
      String address) async {
    isLoadingAddRestaurant.value = true;

    try {
      Map<String, String> body = Map<String, String>();
      body['restaurantName'] = restaurantName;
      body['restaurantDiscription'] = restaurantDiscription;
      body['casinoId'] = casinoId;
      body['restaurantLocation'] = address;

      final response = await _helper.multipartRequestDio(
          "restaurant/add-new-restaurant", body, images);
      isLoadingAddRestaurant.value = false;
      final addRestaurant = AddRestaurant.fromJson(response);
      if (addRestaurant.status == "success") {
        restaurantDetails.value = addRestaurant.restaurantDetails;

        return true;
      } else {
        Utility.showError(addRestaurant.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      log("Error  ${e.toString()}");
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingAddRestaurant.value = false;
    }

    return false;
  }

  Future<bool> addRestaurantReview(
      String restaurantId,
      String restaurantName,
      String casinoId,
      String casinoName,
      String review,
      double rating,
      String address) async {
    isLoadingFoodReview.value = true;

    var rate = rating.toString().split('.');

    Map<String, String> body = Map<String, String>();
    body['restaurantId'] = restaurantId;
    body['restaurantName'] = restaurantName;
    body['casinoId'] = casinoId;
    body['casinoName'] = casinoName;
    body['userId'] = Utility.getUserID();
    body['userName'] = Utility.getUserName();
    body['review'] = review.toString();
    body['rating'] = rate[0].toString();
    body['userPicVersion'] = Utility.getUserProfilePicVersion();
    body['userPicId'] = Utility.getUserProfilePicID();
    body['restaurantLocation'] = address;

    try {
      final response = await _helper.multipartRequestDio(
          "restaurantReviewRating/create-review-rating", body, []);
      log(" Restaurant response ${response}");
      final restaurantReviewRating =
          RestaurantReviewRating.RestaurantReviewRating.fromJson(response);
      isLoadingFoodReview.value = false;
      if (restaurantReviewRating.status == "success") {
        getFoodReviewByCasion(casinoId);
        return true;
      } else {
        Utility.showError(restaurantReviewRating.message);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingFoodReview.value = false;
    }
    return false;
  }

  Future<bool> addHotel(String name, String discription, String casinoId,
      List<File> images, String hotelLocation) async {
    isLoadingFood.value = true;
    try {
      Map<String, String> body = Map<String, String>();
      body['hotelName'] = name;
      body['hotelDiscription'] = discription;
      body['casinoId'] = casinoId;
      body['hotelLocation'] = hotelLocation;

      final response = await _helper.multipartRequestDio(
          "hotel/add-new-hotel", body, images);

      final addHotel = AddHotel.fromJson(response);
      isLoadingFood.value = false;
      if (addHotel.status == "success") {
        hotelDetails.value = addHotel.hotelDetails;
        return true;
      } else {
        Utility.showError(addHotel.message);
      }

      isLoadingFood.value = false;
    } catch (e, s) {
      print('e :  {$s}');
      log("Error  ${e.toString()}");
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingFood.value = false;
    }

    return false;
  }

  Future<bool> addHotelReview(
      String hotelId,
      String hotelName,
      String casinoId,
      String casinoName,
      String review,
      double rating,
      String hotelLocation) async {
    isLoadingFoodReview.value = true;
    var rate = rating.toString().split('.');

    Map<String, String> body = Map<String, String>();
    body['hotelId'] = hotelId;
    body['hotelName'] = hotelName;
    body['casinoId'] = casinoId;
    body['casinoName'] = casinoName;
    body['userId'] = Utility.getUserID();
    body['userName'] = Utility.getUserName();
    body['review'] = review.toString();
    body['rating'] = rate[0].toString();
    body['userPicVersion'] = Utility.getUserProfilePicVersion();
    body['userPicId'] = Utility.getUserProfilePicID();
    body['hotelLocation'] = hotelLocation;

    try {
      final response = await _helper.multipartRequestDio(
          "hotelReviewRating/create-review-rating", (body), []);
      log(" response ${response}");
      final addHotelReview = AddHotelReview.fromJson(response);
      isLoadingFoodReview.value = false;
      if (addHotelReview.status == "success") {
        getHotelReviewByCasion(casinoId);
        return true;
      } else {
        Utility.showError(addHotelReview.message);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingFoodReview.value = false;
    }

    return false;
  }

  Future<bool> addCasionReview(
      String userId,
      String userName,
      String userPicVersion,
      String userPicId,
      String review,
      String rating,
      String casinoId,
      String casinoName,
      String casinoPicVersion,
      String casinoPicId,
      List<File> images) async {
    isLoadingCasion.value = true;
    try {
      Map<String, String> body = Map<String, String>();
      body['casinoId'] = casinoId;
      body['casinoName'] = casinoName;
      body['userId'] = userId;
      body['userName'] = userName;
      body['userPicVersion'] = userPicVersion;
      body['userPicId'] = userPicId;
      body['review'] = review;
      body['rating'] = rating;
      body['casinoPicVersion'] = casinoPicVersion;
      body['casinoPicId'] = casinoPicId;

      final response = await _helper.multipartRequestDio(
          "casinoReviewRating/create-review-rating", body, images);
      print("response $response");
      final addCasionReview = AddCasionReview.fromJson(response);

      isLoadingCasion.value = false;
      if (addCasionReview.status == "success") {
        Utility.updateUserRate(addCasionReview.noOfReviews);
        getCasionReviewCasionDetail(casinoId);
        getUpdateCasinoAvgRating(casinoId);
        // CasionController().getCasinoDetails(casinoId);
        Get.find<CasionController>().getCasinoDetails(casinoId);
        return true;
      } else {
        Utility.showError(addCasionReview.message);
      }

      isLoadingCasion.value = false;
    } catch (e, s) {
      print('e :  {$s}');
      log("Error  ${e.toString()}");
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingCasion.value = false;
    }
    return false;
  }

  void getUpdateCasinoAvgRating(String casionId) async {
    print('getUpdateCasinoAvgRating called() casionId : $casionId');

    dynamic body = {
      'casinoId': casionId,
    };

    try {
      final response = await _helper.post(
          "casinoReviewRating/update-casino-avg-rating", (body));
    } catch (e, s) {
      print('e :  {$s}');
      //Utility.showError(Constant.SERVER_ERROR);
    }
  }

  Future<bool> addForumReview(
      String userID,
      String userName,
      String userProfilePicVersion,
      String userProfilePicID,
      String casionReview,
      String rate,
      String casinoId,
      String casinoName,
      String picVersion,
      String picId,
      List<File> imagesPaths) async {
    isLoadingCasion.value = true;
    try {
      Map<String, String> body = Map<String, String>();
      body['forumName'] = casinoId;
      body['casinoId'] = casinoId;
      body['casinoName'] = casinoName;
      body['userId'] = userID;
      body['userName'] = userName;
      body['review'] = casionReview;
      body['rating'] = rate;
      body['userPicVersion'] = userProfilePicVersion;
      body['userPicId'] = userProfilePicID;

      final response = await _helper.multipartRequestDio(
          "forumReviewRating/create-review-rating", body, imagesPaths);

      final forumReviewRatingResponse =
          ForumReviewRatingResponse.fromJson(response);

      isLoadingCasion.value = false;
      if (forumReviewRatingResponse.status == "success") {
        Utility.showInfo(forumReviewRatingResponse.message);
        getforumReviewRatDetail(casinoId);
        return true;
      } else {
        Utility.showError(forumReviewRatingResponse.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      log("Error  ${e.toString()}");
      //  Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingCasion.value = false;
    }

    return false;
  }

  void getforumReviewRatDetail(String casionId) async {
    print('getforumReviewRatDetail called() casionId : $casionId');
    isLoadingForumReview.value = true;

    dynamic body = {
      'casinoId': casionId,
    };

    try {
      final response = await _helper.post(
          "forumReviewRating/get-review-rating-by-casino", (body));
      GetForumReview.GetForumReview getForumReview =
          GetForumReview.GetForumReview.fromJson(response);
      isLoadingForumReview.value = false;
      if (getForumReview.status == "success") {
        hotelDataForumReview = getForumReview.hotelData;
      } else {
        if (getForumReview.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        Utility.showError(getForumReview.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoadingForumReview.value = false;
    }
  }

  void getGoogleRestaurantNearby(double lat, double longi, double range) async {
    try {
      isGoogleRestaurantNearby.value = true;
      selectedUser.clear();
      final response = await _helper.getGoogle(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$longi&radius=$range&type=restaurant&keyword=restaurant&key=${Constant.mapKey}");

      //log('MapController getGoogleCasionNearby $response');
      GoogleNearby googleNearby = GoogleNearby.fromJson(response);
      if (googleNearby.status == "OK") {
        googleRestaurantNearbyResult.value = googleNearby.results;
        selectedUser.add(googleRestaurantNearbyResult.first);
      } else {
        Utility.showError("No Restaurant Found");
      }
      isGoogleRestaurantNearby.value = false;
    } catch (e, s) {
      print('error :  {$s}');
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isGoogleRestaurantNearby.value = false;
    }
  }

  void getGoogleHotelNearby(double lat, double longi, double range) async {
    try {
      isGoogleHotelNearbyResult.value = true;
      selectedHotelUser.clear();
      final response = await _helper.getGoogle(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$longi&radius=$range&type=hotel&keyword=hotel&key=${Constant.mapKey}");
      // log('MapController getGoogleCasionNearby $response');

      GoogleNearby googleNearby = GoogleNearby.fromJson(response);
      if (googleNearby.status == "OK") {
        googleHotelNearbyResult.value = googleNearby.results;
        selectedHotelUser.add(googleHotelNearbyResult.first);
      } else {
        Utility.showError("No Hotel Found");
      }
      isGoogleHotelNearbyResult.value = false;
    } catch (e, s) {
      print('error :  {$s}');
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isGoogleHotelNearbyResult.value = false;
    }
  }
}
