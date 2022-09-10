import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:casino/controller/community_controller.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/sky_button.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../loading.dart';

class CommunityCustomDialogBox extends StatefulWidget {
  final Size screenSize_;

  const CommunityCustomDialogBox({Key? key, required this.screenSize_})
      : super(key: key);

  @override
  _CommunityCustomDialogBoxState createState() =>
      _CommunityCustomDialogBoxState();
}

class _CommunityCustomDialogBoxState extends State<CommunityCustomDialogBox> {
  final _formKey = GlobalKey<FormState>();
  List<XFile>? imageFileList = [];
  final CommunityController _communityController = Get.find();

  String forumDetail = "";
  String forumName = "";

  _pickMultiImageFromGallery() async {
    ImagePicker _picker = ImagePicker();
    List<XFile>? selectedImage = await _picker.pickMultiImage(
      imageQuality: 50,
    );

    for (var element in selectedImage!) {
      log("CommunityCustomDialogBox element ${element.name}");
    }
    if (selectedImage.isNotEmpty) {
      imageFileList!.addAll(selectedImage);
      setState(() {});
    }
  }

  void _addReview() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    List<File> imagesPaths = [];
    for (var element in imageFileList!) {
      imagesPaths.add(File(element.path));
    }

    if (imagesPaths.length < 1) {
      Utility.showError("selectOneImage".tr);
      return;
    }

    if (imageFileList!.length > 6) {
      Utility.showError("UserPhotoError".tr);
      return;
    }

    _communityController
        .addCRTForum(forumName, forumDetail, imagesPaths)
        .then((value) {
      if (value) {
        Navigator.pop(context, false);
        _communityController.getCoummunity();
      }
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
          height: screenSize.height * 0.9,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "CTRFORUM".tr,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: MyAppTheme.textColor_,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.biotifSemiBold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: screenSize.height * 0.5,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          TextFormField(
                            //cursorColor: MyAppTheme.popupBox,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              // errorStyle:
                              //     const TextStyle(color: MyAppTheme.textWhite),
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 10.0, 30.0),
                              fillColor: MyAppTheme.popupBox,
                              hintText: "casinoForumName".tr,
                              labelStyle:
                                  const TextStyle(color: MyAppTheme.textColor),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                //borderSide:  const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'casinoForumNameEmpty'.tr;
                              }
                            },
                            onSaved: (value) {
                              forumName = value!;
                            },
                          ),
                          const SizedBox(
                            height: 25,
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
                                  cursorColor: MyAppTheme.popupBox,
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
                                    hintText: "comeShareCTR".tr,
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
                                      return 'ForumEmpty'.tr;
                                    }
                                  },
                                  onSaved: (value) {
                                    forumDetail = value!;
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
                  () => _communityController.isForumSubmit.value
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
            backgroundColor: MyAppTheme.infoColor,
            child: ClipRRect(
              child: const Icon(Icons.forum_rounded, color: Colors.white),
              borderRadius: BorderRadius.circular(50.0),
            ),
            radius: 40,
          ),
        ),
      ],
    );
  }
}
