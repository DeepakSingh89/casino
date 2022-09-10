import 'package:casino/controller/map_controller.dart';
import 'package:casino/controller/review_controller.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/model/google_nearby.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/sky_button.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'add_food_star_dialog_box.dart';

class AddFoodReviewDialogBox extends StatefulWidget {
  const AddFoodReviewDialogBox({Key? key, required this.casinoDetail})
      : super(key: key);
  final CasinoDetails casinoDetail;

  @override
  _AddFoodReviewDialogBoxState createState() => _AddFoodReviewDialogBoxState();
}

class _AddFoodReviewDialogBoxState extends State<AddFoodReviewDialogBox> {
  final _formKey = GlobalKey<FormState>();
  List<XFile>? imageFileList = [];
  final ReviewController _reviewController = Get.find();
  final MapController _mapController = Get.find();
  //String restaurantName = "";
  String restaurantDetail = "defultreview";
  bool isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utility.getCurrentLatLong().then((value) {
      var lat = double.parse((value.latitude).toStringAsFixed(4));
      var long = double.parse((value.longitude).toStringAsFixed(4));
      _reviewController.getGoogleHotelNearby(
          lat, long, _mapController.initRange.value);
    });
  }

  _pickMultiImageFromGallery() async {
    ImagePicker _picker = ImagePicker();
    List<XFile>? selectedImage = await _picker.pickMultiImage(imageQuality: 50);
    if (selectedImage!.isNotEmpty) {
      imageFileList!.addAll(selectedImage);
      setState(() {});
    }
  }

  void _addReview() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (imageFileList!.length > 6) {
      Utility.showError("UserPhotoError".tr);
      return;
    }

    if (_reviewController.selectedHotelUser.isEmpty) {
      Utility.showError("selectRes".tr);
      return;
    }

    var dis = await Utility.getCurrentLatLong();
    var lat1 = dis.latitude;
    var long1 = dis.longitude;
    var lat2 = _reviewController.selectedHotelUser.first.geometry.location.lat;
    var long2 = _reviewController.selectedHotelUser.first.geometry.location.lng;
    var dist = Utility.getDistanceBetweeninMeter(lat1, long1, lat2, long2);
    if (dist <= 500) {
    } else {
      Utility.showError("pleasSelect500".tr);
      return;
    }

    if (!isChecked) {
      Utility.showError("pleaseDoCheckin".tr);
      return;
    }

    List<File> imagesPaths = [];
    for (var element in imageFileList!) {
      imagesPaths.add(File(element.path));
    }

    Utility.convertLagLongToAddress(
            _reviewController.selectedHotelUser.first.geometry.location.lat,
            _reviewController.selectedHotelUser.first.geometry.location.lng)
        .then((address) {
      _reviewController
          .addHotel(
              _reviewController.selectedHotelUser.first.name,
              restaurantDetail,
              widget.casinoDetail.casinoId,
              imagesPaths,
              address)
          .then((value) {
        Navigator.pop(context, false);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddFoodStarDialogBox(
                casinoDetail: widget.casinoDetail,
                hotelDetails: _reviewController.hotelDetails.value,
                address: address,
              );
            });
      });
    });
  }

  void _removeIamge(int index) async {
    imageFileList!.removeAt(index);
    setState(() {});
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
      child: contentBox(context, screenSize),
    );
  }

  contentBox(context, Size screenSize) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenSize.height * 0.6,
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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
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
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'checkin'.tr,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        activeColor: Colors.amber,
                        value: isChecked,
                        onChanged: (bool value) {
                          Utility.getCurrentLatLong().then((dis) {
                            var lat1 = dis.latitude;
                            var long1 = dis.longitude;
                            var lat2 = _reviewController
                                .selectedHotelUser.first.geometry.location.lat;
                            var long2 = _reviewController
                                .selectedHotelUser.first.geometry.location.lng;
                            var dist = Utility.getDistanceBetweeninMeter(
                                lat1, long1, lat2, long2);
                            print("dist ${dist}");
                            if (dist <= 500) {
                              setState(() {
                                isChecked = value;
                              });
                            } else {
                              Utility.showError("pleasSelect500".tr);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'selectHotel'.tr,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: screenSize.height * 0.15,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Obx(() => _reviewController
                                  .isGoogleHotelNearbyResult.value
                              ? const Loading(
                                  loadingMessage: '',
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: MyAppTheme.infoColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    border:
                                        Border.all(color: MyAppTheme.infoColor),
                                  ),
                                  padding: const EdgeInsets.only(
                                      right: 12, left: 12),
                                  child: DropdownButton<Results>(
                                      // hint: const Text(
                                      //   "-- Select Hotel --",
                                      //   style: TextStyle(fontSize: 12),
                                      // ),
                                      focusColor: MyAppTheme.dropDown,
                                      style: const TextStyle(
                                          color: MyAppTheme.textWhite),
                                      iconEnabledColor: MyAppTheme.textWhite,
                                      dropdownColor: MyAppTheme.infoColor,
                                      items: _reviewController
                                          .googleHotelNearbyResult.value
                                          .map(
                                            (Results item) =>
                                                DropdownMenuItem<Results>(
                                                    child: Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    value: item),
                                          )
                                          .toList(),
                                      onChanged: (newVal) {
                                        _reviewController.selectedHotelUser
                                            .clear();
                                        _reviewController.selectedHotelUser
                                            .add(newVal!);
                                      },
                                      isDense: false,
                                      isExpanded: true,
                                      value: _reviewController
                                              .selectedHotelUser.isEmpty
                                          ? Results(
                                              name: "",
                                              photos: [],
                                              geometry: Geometry(
                                                location: Location(
                                                    lat: 0.0, lng: 0.0),
                                              ),
                                            )
                                          : _reviewController
                                              .selectedHotelUser.first),
                                )),
                          // TextFormField(
                          //   cursorColor: MyAppTheme.popupBox,
                          //   autofocus: false,
                          //   keyboardType: TextInputType.text,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     contentPadding: const EdgeInsets.fromLTRB(
                          //         20.0, 0.0, 10.0, 30.0),
                          //     fillColor: MyAppTheme.popupBox,
                          //     hintText: "hotelName".tr,
                          //     labelStyle:
                          //         const TextStyle(color: MyAppTheme.textColor),
                          //     alignLabelWithHint: false,
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(15.0),
                          //       borderSide:
                          //           const BorderSide(color: Colors.transparent),
                          //     ),
                          //     focusedBorder: const OutlineInputBorder(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15.0)),
                          //       borderSide:
                          //           BorderSide(color: Colors.transparent),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'HotelNameEmpty'.tr;
                          //     }
                          //   },
                          //   onSaved: (value) {
                          //     restaurantName = value!;
                          //   },
                          // ),
                          // Container(
                          //   height: screenSize.height * 0.27,
                          //   margin: const EdgeInsets.only(top: 20),
                          //   decoration: BoxDecoration(
                          //     color: MyAppTheme.popupBox,
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       // TextFormField(
                          //       //   cursorColor: MyAppTheme.popupBox,
                          //       //   autofocus: false,
                          //       //   keyboardType: TextInputType.multiline,
                          //       //   maxLines: 5,
                          //       //   decoration: InputDecoration(
                          //       //     filled: true,
                          //       //     contentPadding: const EdgeInsets.fromLTRB(
                          //       //         20.0, 0.0, 10.0, 20.0),
                          //       //     fillColor: MyAppTheme.popupBox,
                          //       //     hintText: "hotelDetails".tr,
                          //       //     labelStyle: const TextStyle(
                          //       //         color: MyAppTheme.textColor),
                          //       //     alignLabelWithHint: false,
                          //       //     border: OutlineInputBorder(
                          //       //       borderRadius: BorderRadius.circular(15.0),
                          //       //       borderSide: const BorderSide(
                          //       //           color: MyAppTheme.popupBox,
                          //       //           width: 0.0),
                          //       //     ),
                          //       //     focusedBorder: const OutlineInputBorder(
                          //       //       borderRadius: BorderRadius.all(
                          //       //           Radius.circular(15.0)),
                          //       //       borderSide: BorderSide(
                          //       //           color: MyAppTheme.popupBox),
                          //       //     ),
                          //       //   ),
                          //       //   validator: (value) {
                          //       //     if (value!.isEmpty) {
                          //       //       return 'hotelDetailEmpty'.tr;
                          //       //     }
                          //       //   },
                          //       //   onSaved: (value) {
                          //       //     restaurantDetail = value!;
                          //       //   },
                          //       // ),
                          //       GestureDetector(
                          //         onTap: () => _pickMultiImageFromGallery(),
                          //         child: Container(
                          //           padding: const EdgeInsets.only(
                          //               top: 30, right: 10),
                          //           alignment: Alignment.bottomRight,
                          //           child: const Icon(
                          //             Icons.camera_alt_rounded,
                          //             color: Colors.black,
                          //             size: 30.0,
                          //             textDirection: TextDirection.ltr,
                          //             semanticLabel:
                          //                 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "6Photo".tr,
                        style: const TextStyle(
                            color: MyAppTheme.SMBds, fontSize: 12),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _pickMultiImageFromGallery(),
                      child: Container(
                        width: screenSize.width * 0.1,
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.bottomLeft,
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.black,
                          size: 30.0,
                          textDirection: TextDirection.ltr,
                          semanticLabel:
                              'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                imageFileList!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: imageFileList!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              // childAspectRatio: 3 / 2,
                              //crossAxisCount: 3,
                              //crossAxisSpacing: 5,
                              crossAxisCount: 3,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(
                                      File(
                                        imageFileList![index].path,
                                      ),
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        _removeIamge(index);
                                      },
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      )
                    : const SizedBox(
                        height: 22,
                      ),
                Obx(
                  () => _reviewController.isLoadingFood.value
                      ? const Loading(
                          loadingMessage: '',
                        )
                      : GestureDetector(
                          onTap: () => _addReview(),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
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
            backgroundColor: MyAppTheme.boderColdod,
            child: ClipRRect(
              child: Image.asset(Images.bed),
              borderRadius: BorderRadius.circular(50.0),
            ),
            radius: 40,
          ),
        ),
      ],
    );
  }
}
