import 'dart:io';

import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';

class ProfilePicReward extends StatefulWidget {
  const ProfilePicReward({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  State<ProfilePicReward> createState() => _ProfilePicRewardState();
}

class _ProfilePicRewardState extends State<ProfilePicReward> {
  final GeneralController _generalController = Get.find();
  XFile? imageFile = null;
  String base64Image = '';
  // void _choose() async {
  //   print("_choose");
  //   ImagePicker _picker = ImagePicker();
  //   XFile? image = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       preferredCameraDevice: CameraDevice.rear,
  //       imageQuality: 85,
  //       maxHeight: 200,
  //       maxWidth: 200);

  //   base64Image = base64.encode(utf8.encode(image!.path));
  //   imageFile = image;
  //   File uploadimage = File(image.path);
  //   List<int> imageBytes = uploadimage.readAsBytesSync();
  //   String baseimage = base64Encode(imageBytes);

  //   setState(() {
  //     imageFile = image;
  //   });

  //   _generalController.updateProfilePic(Utility.getUserID(), baseimage);
  // }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('photoLibrary'.tr),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        //  imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setImage(image);
  }

  _imgFromGallery() async {
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      //imageQuality: 50
    );
    setImage(image);
  }

  setImage(XFile? image_) async {
    final filePath = image_!.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      image_.path,
      outPath,
      quality: 20,
    );

    // base64Image = base64.encode(utf8.encode(result!.path));
    setState(() {
      imageFile = image_;
    });
    File uploadimage = File(result!.path);
    List<int> imageBytes = uploadimage.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);

    _generalController.updateProfilePic(Utility.getUserID(), baseimage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    width: widget.screenSize.width * 0.5,
                    margin:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                    child: Text(
                      "viewRewards".tr,
                      style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          color: MyAppTheme.textWhite,
                          fontWeight: FontWeight.bold),
                    )),
                GestureDetector(
                  onTap: () => Get.toNamed(MyRouter.rewardScreen),
                  child: Container(
                    // margin: const EdgeInsets.only(right: 200),
                    width: widget.screenSize.width * 0.5,
                    child: LinearPercentIndicator(
                      // width: 170.0,
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 15.0,
                      //leading: new Text("left content"),
                      //trailing: new Text("right content"),
                      percent: Utility.getUserRate(),
                      //center: Text("20.0%"),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: MyAppTheme.gradientColorTop,
                      animateFromLastPercent: true,
                      backgroundColor: MyAppTheme.gradientColorMid,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Get.toNamed(MyRouter.settingScreen),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),

        SizedBox(
          height: widget.screenSize.height * 0.03,
        ),

        GestureDetector(
          onTap: () => _showPicker(context),
          child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: [
              imageFile == null
                  ? CircleAvatar(
                      backgroundColor: MyAppTheme.textWhite,
                      radius: 65,
                      child: CircleAvatar(
                        radius: 64.0,
                        backgroundImage: Image.network(
                          "${Constant.imageURL}${Utility.getUserProfile()}",
                          //filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: MyAppTheme.textWhite,
                      radius: 65,
                      child: CircleAvatar(
                        radius: 64.0,
                        backgroundImage: Image.file(
                          File(imageFile!.path),
                          //filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
              Positioned(
                right: 0.6,
                top: 85,
                height: widget.screenSize.height * 0.05,
                child: Image.asset(Images.add_profile),
              ),
            ],
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.max,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     SizedBox(width: 20),
        //     CircleAvatar(
        //       radius: 65.0,
        //       backgroundColor: Colors.transparent,
        //       child: ClipRRect(
        //         child:
        //   FadeInImage.assetNetwork(
        //           placeholder: Images.profile_review_dummy,
        //           image: "${Constant.imageURL}${Utility.getUserProfile()}",
        //           fit: BoxFit.fill,
        //           width: screenSize.width * 0.25,
        //           height: screenSize.height * 0.12,
        //         ),
        //         borderRadius: BorderRadius.circular(50.0),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 100),
        //       child: CircleAvatar(
        //         backgroundColor: MyAppTheme.textWhite,
        //         radius: 4.0,
        //         child: ClipRRect(
        //           child: const Text(""),
        //           borderRadius: BorderRadius.circular(50.0),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(width: 2),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 100),
        //       child: CircleAvatar(
        //         backgroundColor: MyAppTheme.textWhite,
        //         radius: 4.0,
        //         child: ClipRRect(
        //           child: Text(""),
        //           borderRadius: BorderRadius.circular(50.0),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(width: 2),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 100),
        //       child: CircleAvatar(
        //         backgroundColor: MyAppTheme.textWhite,
        //         radius: 4.0,
        //         child: ClipRRect(
        //           child: Text(""),
        //           borderRadius: BorderRadius.circular(50.0),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        Container(
          alignment: Alignment.center,
          width: widget.screenSize.width,
          margin: const EdgeInsets.only(top: 10),
          child: LightTextHead(data: Utility.getUserName()),
        ),

        Container(
          alignment: Alignment.center,
          width: widget.screenSize.width,
          margin: const EdgeInsets.only(top: 10),
          child: LightTextSubHead(data: Utility.getEmailAddress()),
        ),
        // Container(
        //   alignment: Alignment.center,
        //   width: screenSize.width,
        //   margin: const EdgeInsets.only(top: 5),
        //   child: YellowTextBody(data: "Rating: ${Utility.getUserRate()} of 5"),
        // ),
      ],
    );
  }
}
