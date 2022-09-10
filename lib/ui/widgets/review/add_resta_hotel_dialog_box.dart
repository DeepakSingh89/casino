import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/widgets/add_forum_review.dart';
import 'package:casino/ui/widgets/review/food/add_food_review_dialog_box.dart';
import 'package:casino/ui/widgets/review/restaurant/add_restaurant_review_dialog_box.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddRestaHotelDialogBox extends StatefulWidget {
  const AddRestaHotelDialogBox({Key? key, required this.casinoDetail})
      : super(key: key);
  final CasinoDetails casinoDetail;

  @override
  _AddRestaHotelDialogBoxState createState() => _AddRestaHotelDialogBoxState();
}

class _AddRestaHotelDialogBoxState extends State<AddRestaHotelDialogBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constant.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              //left: Constant.padding,
              top: 20,
              //right: Constant.padding,
              bottom: Constant.padding),
          margin: const EdgeInsets.only(top: Constant.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: MyAppTheme.textWhite,
            borderRadius: BorderRadius.circular(Constant.padding),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                //height: doub,
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      color: MyAppTheme.textColorkk__,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "aDDCASINOINFO".tr,
                              style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: MyAppTheme.textColor_,
                                  fontFamily: Fonts.biotifSemiBold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              widget.casinoDetail.casinoName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 24,
                                  color: MyAppTheme.textColor_,
                                  fontFamily: Fonts.biotifSemiBold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.casinoDetail.address,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                  color: MyAppTheme.textColorkk,
                                  fontFamily: Fonts.biotifSemiBold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      color: MyAppTheme.textWhite,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "aDDRESTAURANTHOTELNEARBY".tr,
                              style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                  color: MyAppTheme.textCol__,
                                  fontFamily: Fonts.biotifNormal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 50, bottom: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AddRestaurantReviewDialogBox(
                                            casinoDetail: widget.casinoDetail);
                                      }),
                                  child: CircleAvatar(
                                    backgroundColor: MyAppTheme.infoColor,
                                    child: ClipRRect(
                                      child: Image.asset(Images.food),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    radius: 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AddFoodReviewDialogBox(
                                            casinoDetail: widget.casinoDetail);
                                      }),
                                  child: CircleAvatar(
                                    backgroundColor: MyAppTheme.boderColdod,
                                    child: ClipRRect(
                                      child: Image.asset(Images.bed),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    radius: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 50),
                            child: GestureDetector(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddForumReview(
                                        casinoDetail: widget.casinoDetail);
                                  }),
                              child: CircleAvatar(
                                backgroundColor: MyAppTheme.pinCircleColor,
                                child: ClipRRect(
                                  child: const Icon(
                                    Icons.forum_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                radius: 40,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
        Positioned(
          left: Constant.padding,
          right: Constant.padding,
          child: CircleAvatar(
            backgroundColor: MyAppTheme.gradientColorTop,
            child: ClipRRect(
              child: Image.asset(Images.noun_casino),
              borderRadius: BorderRadius.circular(50.0),
            ),
            radius: 32,
          ),
        ),
        Positioned(
          top: 20,
          right: 0,
          left: 35,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: MyAppTheme.gradientColorMid,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
