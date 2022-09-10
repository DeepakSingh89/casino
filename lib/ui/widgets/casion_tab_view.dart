import 'package:casino/controller/review_controller.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/review/details/casion_detail_dialog_box.dart';
import 'package:casino/ui/widgets/review/details/community_detail_dialog_box.dart';
import 'package:casino/ui/widgets/review/details/food_detail_dialog_box.dart';
import 'package:casino/ui/widgets/review/details/hotel_detail_dialog_box.dart';
import 'package:casino/ui/widgets/review/food/review_item_food.dart';
import 'package:casino/ui/widgets/review_item.dart';
import 'package:casino/ui/widgets/review/restaurant/review_item_restaurant.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading.dart';

class CasionTabView extends StatefulWidget {
  CasionTabView({
    Key? key,
    required this.screenSize,
    required TabController tabController,
    required this.casionId,
    required this.casinoDetail,
  })  : _tabController = tabController,
        super(key: key);

  final Size screenSize;
  final TabController _tabController;
  final String casionId;
  final CasinoDetails casinoDetail;

  @override
  State<CasionTabView> createState() => _CasionTabViewState();
}

class _CasionTabViewState extends State<CasionTabView> {
  final ReviewController _reviewController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewController.getCasionReviewCasionDetail(widget.casionId);
    _reviewController.getHotelReviewByCasion(widget.casionId);
    _reviewController.getFoodReviewByCasion(widget.casionId);
    _reviewController.getforumReviewRatDetail(widget.casionId);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Obx(
            () => _reviewController.isLoadingCasionReview.value
                ? const Loading(
                    loadingMessage: '',
                  )
                : _reviewController.casinoData.isEmpty
                    ? Center(child: LightTextHead(data: "NOREVIEW".tr))
                    : ListView.builder(
                        itemCount: _reviewController.casinoData.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            //Navigator.pop(context, false);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CasionDetailDialogBox(
                                    casinoData:
                                        _reviewController.casinoData[index],
                                  );
                                });
                          },
                          child: ReviewItem(
                            screenSize: widget.screenSize,
                            title: _reviewController.casinoData[index].userName,
                            date: Utility.getDate(_reviewController
                                .casinoData[index].createdDate),
                            subTitle:
                                _reviewController.casinoData[index].review,
                            imageURL:
                                "${Constant.imageURL}${_reviewController.casinoData[index].userPicVersion}/${_reviewController.casinoData[index].userPicId}",
                            rate: _reviewController.casinoData[index].rating,
                          ),
                        ),
                      ),
          ),
          Obx(
            () => _reviewController.isLoadingFood.value
                ? const Loading(
                    loadingMessage: '',
                  )
                : _reviewController.restaurantReviewResponsehotelData.isEmpty
                    ? Center(child: LightTextHead(data: "NOREVIEW".tr))
                    : ListView.builder(
                        itemCount: _reviewController
                            .restaurantReviewResponsehotelData.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            //Navigator.pop(context, false);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return FoodDetailDialogBox(
                                    restaurantData: _reviewController
                                            .restaurantReviewResponsehotelData[
                                        index],
                                  );
                                });
                          },
                          child: ReviewItemRestaurant(
                              screenSize: widget.screenSize,
                              title: _reviewController
                                  .restaurantReviewResponsehotelData[index]
                                  .restaurantName,
                              date: Utility.getDate(_reviewController
                                  .restaurantReviewResponsehotelData[index]
                                  .createdDate),
                              subTitle: _reviewController
                                  .restaurantReviewResponsehotelData[index]
                                  .review,
                              imageURL:
                                  "${Constant.imageURL}${_reviewController.restaurantReviewResponsehotelData[index].userPicVersion}/${_reviewController.restaurantReviewResponsehotelData[index].userPicId}",
                              rate: _reviewController
                                  .restaurantReviewResponsehotelData[index]
                                  .rating,
                              restaurantReviewResponsehotelData:
                                  _reviewController
                                      .restaurantReviewResponsehotelData[index],
                              casinoDetail: widget.casinoDetail),
                        ),
                      ),
          ),
          Obx(
            () => _reviewController.isLoadingHotel.value
                ? const Loading(
                    loadingMessage: '',
                  )
                : _reviewController.hotelData.isEmpty
                    ? Center(child: LightTextHead(data: "NOREVIEW".tr))
                    : ListView.builder(
                        itemCount: _reviewController.hotelData.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            //Navigator.pop(context, false);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return HotelDetailDialogBox(
                                    hotelData:
                                        _reviewController.hotelData[index],
                                  );
                                });
                          },
                          child: ReviewItemFood(
                              screenSize: widget.screenSize,
                              title:
                                  _reviewController.hotelData[index].hotelName,
                              date: Utility.getDate(_reviewController
                                  .hotelData[index].createdDate),
                              subTitle:
                                  _reviewController.hotelData[index].review,
                              imageURL:
                                  "${Constant.imageURL}${_reviewController.hotelData[index].userPicVersion}/${_reviewController.hotelData[index].userPicId}",
                              rate: _reviewController.hotelData[index].rating,
                              hotelData: _reviewController.hotelData[index],
                              casinoDetail: widget.casinoDetail),
                        ),
                      ),
          ),
          Obx(
            () => _reviewController.isLoadingForumReview.value
                ? const Loading(
                    loadingMessage: '',
                  )
                : _reviewController.hotelDataForumReview.isEmpty
                    ? Center(child: LightTextHead(data: "NOREVIEW".tr))
                    : ListView.builder(
                        itemCount:
                            _reviewController.hotelDataForumReview.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            //Navigator.pop(context, false);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CommunityDetailDialogBox(
                                    hotelDataForumReview: _reviewController
                                        .hotelDataForumReview[index],
                                  );
                                });
                          },
                          child: ReviewItem(
                            screenSize: widget.screenSize,
                            title: _reviewController
                                .hotelDataForumReview[index].userName,
                            date: Utility.getDate(_reviewController
                                .hotelDataForumReview[index].createdDate),
                            subTitle: _reviewController
                                .hotelDataForumReview[index].review,
                            imageURL:
                                "${Constant.imageURL}${_reviewController.hotelDataForumReview[index].userPicVersion}/${_reviewController.hotelDataForumReview[index].userPicId}",
                            rate: _reviewController
                                .hotelDataForumReview[index].rating,
                          ),
                        ),
                      ),
          ),
        ],
        controller: widget._tabController,
      ),
    );
  }
}
