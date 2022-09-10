import 'package:casino/controller/review_controller.dart';
import 'package:casino/model/add_restaurant.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/sky_button.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class AddRestaurantStarDialogBox extends StatefulWidget {
  const AddRestaurantStarDialogBox({
    Key? key,
    required this.casinoDetail,
    required this.restaurantDetails,
    required this.address,
  }) : super(key: key);
  final CasinoDetails casinoDetail;
  final RestaurantDetails restaurantDetails;
  final String address;
  @override
  _AddRestaurantStarDialogBoxState createState() =>
      _AddRestaurantStarDialogBoxState();
}

class _AddRestaurantStarDialogBoxState
    extends State<AddRestaurantStarDialogBox> {
  final _formKey = GlobalKey<FormState>();
  var foodReview = "";
  var ratingValue = 0.0;

  final ReviewController _reviewController = Get.find();

  void _addReview() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (ratingValue == 0.0) {
      Utility.showError("pleaseProvideRating".tr);
      return;
    }

    _reviewController
        .addRestaurantReview(
            widget.restaurantDetails.restaurantId,
            widget.restaurantDetails.restaurantName,
            widget.casinoDetail.casinoId,
            widget.casinoDetail.casinoName,
            foodReview,
            ratingValue,
            widget.address)
        .then((value) {
      if (value) {
        Navigator.pop(context, false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constant.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            height: screenSize.height,
            padding: const EdgeInsets.only(
                //left: Constant.padding,
                top: 35,
                //right: Constant.padding,
                bottom: Constant.padding),
            margin: const EdgeInsets.only(top: Constant.avatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constant.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: MyAppTheme.textColorkk__,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "fOODREVIEW".tr,
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
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 5, bottom: 10),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         'checkin'.tr,
                        //         style: const TextStyle(
                        //             fontSize: 14,
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //       Switch(
                        //         activeColor: Colors.amber,
                        //         value: isChecked,
                        //         onChanged: (bool value) {
                        //           setState(() {
                        //             isChecked = value;
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "rATETHISFOOD".tr,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: MyAppTheme.textColor,
                        fontFamily: Fonts.biotifSemiBold),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      ratingValue = rating;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: screenSize.height * 0.35,
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              height: screenSize.height * 0.27,
                              margin: const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                color: MyAppTheme.popupBox,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    cursorColor: MyAppTheme.black,
                                    autofocus: false,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      // errorStyle: const TextStyle(
                                      //     color: MyAppTheme.black),
                                      filled: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 0.0, 10.0, 20.0),
                                      fillColor: MyAppTheme.popupBox,
                                      hintText: "TellWorldHotel".tr,
                                      labelStyle: const TextStyle(
                                          color: MyAppTheme.textColor),
                                      alignLabelWithHint: false,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                            color: MyAppTheme.popupBox,
                                            width: 0.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        borderSide: BorderSide(
                                            color: MyAppTheme.popupBox),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Food review is empty';
                                      }
                                    },
                                    onSaved: (value) {
                                      foodReview = value!;
                                    },
                                  ),
                                  // GestureDetector(
                                  //   onTap: () => _pickMultiImageFromGallery(),
                                  //   child: Container(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 30, right: 10),
                                  //     alignment: Alignment.bottomRight,
                                  //     child: const Icon(
                                  //       Icons.camera_alt_rounded,
                                  //       color: Colors.black,
                                  //       size: 30.0,
                                  //       textDirection: TextDirection.ltr,
                                  //       semanticLabel:
                                  //           'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => _reviewController.isLoadingFoodReview.value
                        ? const Loading(
                            loadingMessage: '',
                          )
                        : GestureDetector(
                            onTap: () => _addReview(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: SkyButton(
                                  buttonText: "SUBMIT".tr,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: Constant.padding,
            right: Constant.padding,
            child: CircleAvatar(
              backgroundColor: MyAppTheme.infoColor,
              child: ClipRRect(
                child: Image.asset(Images.food),
                borderRadius: BorderRadius.circular(50.0),
              ),
              radius: 40,
            ),
          ),
        ],
      ),
    );
  }
}
