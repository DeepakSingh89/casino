import 'dart:io';

import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/styles/my_strings.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class AddProfilePicScreen extends StatefulWidget {
  const AddProfilePicScreen({Key? key}) : super(key: key);

  @override
  _AddProfilePicScreenState createState() => _AddProfilePicScreenState();
}

class _AddProfilePicScreenState extends State<AddProfilePicScreen> {
  XFile? imageFile = null;
  String base64Image = '';
  late Future<PickedFile> file;

  final _formKey = GlobalKey<FormState>();
  String userName = "";

  _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (MySingleton.shared.socialMediaProfilePci.isNotEmpty) {
      _commonMethod();
    } else if (imageFile != null) {
      _commonMethod();
    } else {
      Utility.showError("pleaseSelectProfile".tr);
      return;
    }
  }

  _commonMethod() {
    _formKey.currentState!.save();

    MySingleton.shared.username = userName;

    if (imageFile != null)
      MySingleton.shared.image = imageFile!.path.toString();

    print(
        " username : ${MySingleton.shared.username} image :  ${MySingleton.shared.image} ");
    // Get.toNamed(MyRouter.addPasswordScreen);
    Get.offAndToNamed(MyRouter.addPasswordScreen);
  }

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
      quality: 5,
    );

    base64Image = base64.encode(utf8.encode(result!.path));
    setState(() {
      imageFile = image_;
      File uploadimage = File(result.path);
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      MySingleton.shared.uploadImage = baseimage;
    });
  }

  void _choose() async {
    print("_choose");
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 85,
        maxHeight: 200,
        maxWidth: 200);

    base64Image = base64.encode(utf8.encode(image!.path));
    setState(() {
      imageFile = image;
      File uploadimage = File(image.path);
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      MySingleton.shared.uploadImage = baseimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        //backgroundColor: MyAppTheme.appBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyAppTheme.gradientColorTop,
                  MyAppTheme.gradientColorMid,
                  MyAppTheme.gradientColorLast
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: LightTextHead(data: 'createProfile'.tr),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _showPicker(context),
                        child: MySingleton
                                .shared.socialMediaProfilePci.isNotEmpty
                            ? Stack(
                                overflow: Overflow.visible,
                                fit: StackFit.loose,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: MyAppTheme.textWhite,
                                    radius: 65,
                                    child: CircleAvatar(
                                      radius: 64.0,
                                      backgroundImage: Image.network(
                                        MySingleton
                                            .shared.socialMediaProfilePci,
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover,
                                      ).image,
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    top: 95,
                                    child: Image.asset(Images.add_profile),
                                  ),
                                ],
                              )
                            : imageFile == null
                                ? Stack(
                                    overflow: Overflow.visible,
                                    fit: StackFit.loose,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: MyAppTheme.textWhite,
                                        radius: 65,
                                        child: CircleAvatar(
                                          radius: 64.0,
                                          backgroundImage: Image.asset(
                                            Images.profilePic,
                                            //filterQuality: FilterQuality.high,
                                            fit: BoxFit.cover,
                                          ).image,
                                        ),
                                      ),
                                      Positioned(
                                        right: 2,
                                        top: 95,
                                        //height: screenSize.height * 0.04,
                                        child: Image.asset(Images.add_profile),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    overflow: Overflow.visible,
                                    fit: StackFit.loose,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: MyAppTheme.textWhite,
                                        radius: 65,
                                        child: CircleAvatar(
                                          radius: 64.0,
                                          backgroundImage: Image.file(
                                            File(imageFile!.path),
                                            filterQuality: FilterQuality.high,
                                            fit: BoxFit.cover,
                                          ).image,
                                        ),
                                      ),
                                      Positioned(
                                        right: 2,
                                        top: 95,
                                        child: Image.asset(Images.add_profile),
                                      ),
                                    ],
                                  ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 25, left: 40, right: 40),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            initialValue: MySingleton.shared.username,
                            cursorColor: MyAppTheme.gradientColorTop,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(color: MyAppTheme.textWhite),
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 25.0, 50, 25.0),
                              fillColor: MyAppTheme.textWhite,
                              hintText: 'userName'.tr,
                              //labelText: MyStrings.userName,
                              labelStyle: const TextStyle(
                                  color: MyAppTheme.gradientColorLast),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    color: MyAppTheme.gradientColorMid),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    color: MyAppTheme.gradientColorMid),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enterUserName'.tr;
                              }

                              if (value.contains(' ')) {
                                return ' '.tr;
                                //userNameSpace
                              }

                              if (value.length < 3) {
                                return "shouldBeMoreThen3".tr;
                              }

                              if (value.length > 10) {
                                return "shouldBeless30".tr;
                              }

                              // if (value.trim() != '') {
                              //   return 'userNameSpace'.tr;
                              // }
                              // if (value.length < 10) {
                              //   return 'Enter 10 digit mobile';
                              // }
                            },
                            onSaved: (value) {
                              userName = value!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(width: screenSize.width * 0.4),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.textSecondary,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.textSecondary,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.gradientColorTop,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.textSecondary,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: GestureDetector(
                          onTap: () => _submit(),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 35, right: 35, bottom: 35),
                            alignment: Alignment.bottomCenter,
                            child: DarkButton(buttonText: 'next'.tr),
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
    );
  }
}
