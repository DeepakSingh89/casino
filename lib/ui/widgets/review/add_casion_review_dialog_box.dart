import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:casino/controller/review_controller.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/sky_button.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCasionReviewDialogBox extends StatefulWidget {
  const AddCasionReviewDialogBox({Key? key, required this.casinoDetail})
      : super(key: key);
  final CasinoDetails casinoDetail;

  @override
  _AddCasionReviewDialogBoxState createState() =>
      _AddCasionReviewDialogBoxState();
}

class _AddCasionReviewDialogBoxState extends State<AddCasionReviewDialogBox> {
  final _formKey = GlobalKey<FormState>();
  List<XFile>? imageFileList = [];
  final ReviewController _reviewController = Get.find();
  var casionReview = "";
  var ratingValue = 0.0;

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

    if (ratingValue == 0.0) {
      Utility.showError("pleaseProvideRating".tr);
      return;
    }

    if (imageFileList!.length > 6) {
      Utility.showError("UserPhotoError".tr);
      return;
    }

    List<File> imagesPaths = [];
    for (var element in imageFileList!) {
      imagesPaths.add(File(element.path));
    }

    var rate = ratingValue.toString().split('.');
    _reviewController
        .addCasionReview(
            Utility.getUserID(),
            Utility.getUserName(),
            Utility.getUserProfilePicVersion(),
            Utility.getUserProfilePicID(),
            casionReview,
            rate[0],
            widget.casinoDetail.casinoId,
            widget.casinoDetail.casinoName,
            widget.casinoDetail.picVersion,
            widget.casinoDetail.picId,
            imagesPaths)
        .then((value) {
      Navigator.pop(context, false);
      Utility.showInfo("reviewAdded".tr);
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
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: screenSize.height * 0.35,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 40.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              ratingValue = rating;
                            },
                          ),
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
                                    //     color: MyAppTheme.textWhite),
                                    filled: true,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 10.0, 20.0),
                                    fillColor: MyAppTheme.popupBox,
                                    hintText: "tellCasinoExperience".tr,
                                    labelStyle: const TextStyle(
                                        color: MyAppTheme.textColor),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
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
                                      return 'reviewDetailEmpty'.tr;
                                    }
                                  },
                                  onSaved: (value) {
                                    casionReview = value!;
                                  },
                                ),
                                GestureDetector(
                                  onTap: () => _pickMultiImageFromGallery(),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 30, right: 10),
                                    alignment: Alignment.bottomRight,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 135),
                  child: Text(
                    "6Photo".tr,
                    style:
                        const TextStyle(color: MyAppTheme.SMBds, fontSize: 12),
                  ),
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
                GestureDetector(
                  onTap: () => _addReview(),
                  child: Obx(
                    () => _reviewController.isLoadingCasion.value
                        ? const Loading(
                            loadingMessage: '',
                          )
                        : Padding(
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
              child: Image.asset(Images.noun_casino),
              borderRadius: BorderRadius.circular(50.0),
            ),
            radius: 40,
          ),
        ),
      ],
    );
  }
}
