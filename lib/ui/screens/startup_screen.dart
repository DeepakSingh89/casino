import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/my_strings.dart';
import 'package:casino/ui/widgets/dark_with_board_button.dart';
import 'package:casino/ui/widgets/green_light_button.dart';
import 'package:casino/ui/widgets/green_lighter_button.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:get/get.dart';

import '../../ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/images.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: MyAppTheme.welcomeTop),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenSize.height * 0.6,
                color: MyAppTheme.welcomeTop,
                // decoration: const BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       MyAppTheme.gradientColorTop,
                //       MyAppTheme.gradientColorMid,
                //       MyAppTheme.gradientColorLast
                //     ],
                //     begin: Alignment.center,
                //     end: Alignment.bottomCenter,
                //   ),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                    LightTextBody(data: "Welcome to"),
                    LightTextHead(data: "Casino TR"),
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        Images.logo,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height * 0.4,
                color: MyAppTheme.welcomeBottom,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyAppTheme.abch,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Casino TR'),
                            TextSpan(
                              text:
                                  " is an app that connects users Closer to the casino than ever before. See a breakdown of reviews from food, hotel, and overall casino.",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: MyAppTheme.abc,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(MyRouter.languageSelectScreen),
                      child: Container(
                        margin: const EdgeInsets.only(left: 50, right: 50),
                        alignment: Alignment.bottomCenter,
                        child: GreenLightButton(buttonText: 'joinNow'.tr),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.025,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(MyRouter.loginScreen),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 50, right: 50, bottom: 35),
                        alignment: Alignment.bottomCenter,
                        child: GreenLighterButton(buttonText: 'login'.tr),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
