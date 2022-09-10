import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/styles/my_strings.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  final GeneralController _generalController = Get.find();
  _storeValue(String lang, String val) {
    MySingleton.shared.language = lang;
    print("language ${MySingleton.shared.language} ");

    if (val == "val1") {
      setState(() {
        val1 = true;
        val2 = false;
      });
    } else if (val == "val2") {
      setState(() {
        val1 = false;
        val2 = true;
      });
    }

    _generalController.changeLanguage(lang);
  }

  bool val1 = false;
  bool val2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (MySingleton.shared.language.isEmpty) {
      MySingleton.shared.language = "en";
      val1 = false;
      val2 = true;
    } else {
      if (MySingleton.shared.language == "en" ||
          MySingleton.shared.language == "English") {
        MySingleton.shared.language = "en";
        val1 = false;
        val2 = true;
      } else {
        MySingleton.shared.language = "sp";
        val1 = true;
        val2 = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: MyAppTheme.appBackgroundColor,
        body: Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: screenSize.height * 0.09,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  'selectLanguage'.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 26,
                      color: MyAppTheme.textWhite,
                      fontFamily: Fonts.biotifSemiBold),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.6,
                child: ListView(
                  children: <Widget>[
                    Container(
                      color: val2 == true
                          ? MyAppTheme.gradientColorMid
                          : Colors.transparent,
                      child: GestureDetector(
                        onTap: () => _storeValue("en", "val2"),
                        child: flagImageSelect(
                            Images.englishLang, MyStrings.english, screenSize),
                      ),
                    ),
                    Container(
                      color: val1 == true
                          ? MyAppTheme.gradientColorMid
                          : Colors.transparent,
                      child: GestureDetector(
                        onTap: () => _storeValue("sp", "val1"),
                        child: flagImageSelect(
                            Images.spainFlag, MyStrings.spanish, screenSize),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
// Get.toNamed(MyRouter.locationPermissionScreen),
                  Get.offAndToNamed(MyRouter.locationPermissionScreen);
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 35),
                  alignment: Alignment.bottomCenter,
                  child: DarkButton(buttonText: 'next'.tr),
                ),
              ),
            ],
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   mainAxisSize: MainAxisSize.max,
          //   children: <Widget>[
          //     SizedBox(
          //       height: screenSize.height * 0.01,
          //     ),
          //     Column(
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Container(
          //           margin: const EdgeInsets.only(left: 15),
          //           alignment: Alignment.topLeft,
          //           child: LightTextHead(
          //             data: MyStrings.selectLanguage,
          //           ),
          //         ),
          //         SizedBox(
          //           height: screenSize.height * 0.05,
          //         ),
          //         InkWell(
          //           highlightColor: MyAppTheme.gradientColorMid,
          //           onTap: () => _test,
          //           child: flagImageSelect(
          //               Images.englishLang, MyStrings.english, screenSize),
          //         ),
          //         SizedBox(
          //           height: screenSize.height * 0.01,
          //         ),
          //         InkWell(
          //           highlightColor: MyAppTheme.gradientColorMid,
          //           onTap: () => _test,
          //           child: flagImageSelect(
          //               Images.spainFlag, MyStrings.spanish, screenSize),
          //         ),
          //       ],
          //     ),
          //     GestureDetector(
          //       child: Container(
          //         margin: const EdgeInsets.only(left: 35, right: 35, bottom: 35),
          //         alignment: Alignment.bottomCenter,
          //         child: DarkButton(buttonText: MyStrings.next),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  ListTile flagImageSelect(String ellipse, String subTitle, Size screenSize) {
    return ListTile(
      leading: Image.asset(
        ellipse,
        height: screenSize.height * 1,
        width: screenSize.width * 0.2,
      ),
      title: LightTextHead(data: subTitle),
    );
  }
}
