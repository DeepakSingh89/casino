import 'package:casino/controller/casion_controller.dart';
import 'package:casino/controller/review_controller.dart';
import 'package:casino/model/user_login.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/screens/favorite_casion_screen.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/profile_card.dart';
import 'package:casino/ui/widgets/profile_favorite_card.dart';
import 'package:casino/ui/widgets/profile_review_top_sea_all.dart';
import 'package:casino/ui/widgets/recent_casion_list.dart';
import 'package:casino/ui/widgets/review_item.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProfileList extends StatefulWidget {
  ProfileList({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  final ReviewController _reviewController = Get.find();
  final CasionController _casionController = Get.find();
  // var favourite = Favourite(
  //   casinoId: "",
  //   casinoName: "",
  //   casinoDiscription: "",
  //   picVersion: "",
  //   picId: "",
  //   location: [],
  // );

  var user = User(
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
  String meter = "";
  @override
  void initState() {
    super.initState();
    user = Utility.getUser();
    // favourite = user.favourite[0];
    // display();
  }

  display() {
    Utility.getCurrentLatLong().then((value) {
      var lat = double.parse((value.latitude).toStringAsFixed(4));
      var long = double.parse((value.longitude).toStringAsFixed(4));
      setState(() {
        meter =
            "${Utility.getDistanceBetween(lat, long, _casionController.favouriteList[0].location[0], _casionController.favouriteList[0].location[1])}} ${'meterAway'.tr}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecentCasionList(
          screenSize: widget.screenSize,
        ),
        Obx(
          () => _reviewController.isLoadingCasion.value
              ? const Loading(
                  loadingMessage: '',
                )
              : Column(
                  children: [
                    SizedBox(
                      height: widget.screenSize.height * 0.01,
                    ),
                    const Divider(height: 4, color: MyAppTheme.dividedCol),
                    SizedBox(
                      height: widget.screenSize.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_reviewController
                            .casinoUserReviewRating.isNotEmpty) {
                          Get.toNamed(MyRouter.casionUserReviewScreen,
                              arguments:
                                  _reviewController.casinoUserReviewRating);
                        }
                      },
                      child: ProfileReviewTopSeaAll(
                        screenSize: widget.screenSize,
                        title: "Reviews".tr,
                        isVisiable:
                            _reviewController.casinoUserReviewRating.isNotEmpty
                                ? true
                                : false,
                      ),
                    ),
                    _reviewController.casinoUserReviewRating.isNotEmpty
                        ? ReviewItem(
                            screenSize: widget.screenSize,
                            title: _reviewController
                                .casinoUserReviewRating[0].casinoName,
                            date: Utility.getDate(_reviewController
                                .casinoUserReviewRating[0].createdDate),
                            subTitle: _reviewController
                                .casinoUserReviewRating[0].review,
                            imageURL:
                                "${Constant.imageURL}${_reviewController.casinoUserReviewRating[0].userPicVersion}/${_reviewController.casinoUserReviewRating[0].userPicId}",
                            rate: _reviewController
                                .casinoUserReviewRating[0].rating,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: LightTextSubHead(data: "noData".tr),
                          ),
                  ],
                ),
        ),
        SizedBox(
          height: widget.screenSize.height * 0.05,
        ),
        const Divider(height: 4, color: MyAppTheme.dividedCol),
        Obx(
          () => _casionController.isLoadingFavCasionReview.value
              ? const Loading(
                  loadingMessage: '',
                )
              : Column(
                  children: [
                    SizedBox(
                      height: widget.screenSize.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_casionController.favouriteList.isNotEmpty) {
                          Get.toNamed(MyRouter.favoriteCasio,
                              arguments: _casionController.favouriteList);
                        }
                      },
                      child: ProfileReviewTopSeaAll(
                        screenSize: widget.screenSize,
                        title: "Favorites".tr,
                        isVisiable: _casionController.favouriteList.isNotEmpty
                            ? true
                            : false,
                      ),
                    ),
                    SizedBox(
                      height: widget.screenSize.height * 0.02,
                    ),
                    _casionController.favouriteList.isNotEmpty
                        ? ProfileFavoriteCard(
                            screenSize: widget.screenSize,
                            imageURL: "${Constant.imageURL}${_casionController.favouriteList[0].picVersion}/${_casionController.favouriteList[0].picId}",
                            title:
                                _casionController.favouriteList[0].casinoName,
                            subTitle: _casionController
                                .favouriteList[0].casinoDiscription,
                            address: "",
                            max: "200",
                            min: "200",
                            distance: "",
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: LightTextSubHead(data: "noData".tr),
                          ),

                  ],
                ),
        ),
      ],
    );
  }
}
