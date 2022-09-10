import 'dart:developer';

import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/screens/general_screen.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/green_light_button.dart';
import 'package:casino/ui/widgets/grey_light_button.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isCheckedNotifications = false;
  bool isCheckedLocation = false;
  final GeneralController _generalController = Get.find();

  List<String> langs = ['English', 'Spanish'];
  var lang = "English";

  String getLang() {
    lang = "English";
    if (MySingleton.shared.userLang == 'English' ||
        MySingleton.shared.userLang == 'en') {
      lang = 'English';
    } else if (MySingleton.shared.userLang == 'Spanish' ||
        MySingleton.shared.userLang == 'sp') {
      lang = 'Spanish';
    }

    return lang;
  }

  @override
  void initState() {
    super.initState();
    _generalController.getStaticPage();
    setState(() {
      lang = getLang();
    });
  }

  updateLang(String lang_) async {
    _generalController.changeLanguage(lang_);
    _generalController.updateLanguageByUser(Utility.getUserID(), lang_);
    setState(() {
      lang = lang_;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.backgroundBlack,
        body: Column(
          children: [
            ProfileHead(
              isBackArrow: false,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20, left: 10),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 15),
                  child: LightTextHead(data: "Settings".tr),
                ),
                const SizedBox(
                  width: 30,
                )
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 30,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: LightTextBody(data: "Notifications".tr),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.3,
                        ),
                        Switch(
                          activeColor: MyAppTheme.gradientColorTop,
                          value: isCheckedNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              isCheckedNotifications = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: LightTextBody(data: "Location".tr),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.3,
                        ),
                        Switch(
                          activeColor: MyAppTheme.gradientColorTop,
                          value: isCheckedLocation,
                          onChanged: (bool value) {
                            setState(() {
                              isCheckedLocation = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: LightTextBody(data: "Language".tr),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.2,
                        ),
                        DropdownButton(
                          focusColor: MyAppTheme.dropDown,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: MyAppTheme.dropDown,
                          dropdownColor: MyAppTheme.dropDown,
                          items: langs
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (newVal) {
                            log("newVal : ${newVal}");
                            updateLang(newVal.toString());
                          },
                          isExpanded: false,
                          value: lang,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(MyRouter.changePasswordScreen),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: LightTextBody(data: "Change Password".tr),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.3,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: MyAppTheme.dropDown),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(
                        () => GeneralScreen(
                          title: "TermsAndCondition".tr,
                          body: _generalController
                              .staticPageData[0].termAndCondition,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: LightTextBody(data: "TermsAndCondition".tr),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.2,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: MyAppTheme.dropDown),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(
                        () => GeneralScreen(
                          title: "privacyPolicy".tr,
                          body: _generalController
                              .staticPageData[0].privacyPolicy,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: LightTextBody(data: "privacyPolicy".tr),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.25,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: MyAppTheme.dropDown),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(
                        () => GeneralScreen(
                          title: "AboutUs".tr,
                          body: _generalController.staticPageData[0].aboutUs,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: LightTextBody(data: "AboutUs".tr),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.3,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: MyAppTheme.dropDown),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: "logoutPopup".tr,
                  titlePadding: const EdgeInsets.all(10),
                  content: const Text(
                    "",
                  ),
                  textConfirm: "yes".tr,
                  textCancel: "no".tr,
                  buttonColor: MyAppTheme.darkButtonColor,
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.black,
                  onConfirm: () => Utility.logout(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 60, left: 60, top: 30),
                child: GreenLightButton(buttonText: "Logout".tr),
              ),
            )
          ],
        ),
      ),
    );
  }
}
