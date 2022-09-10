import 'dart:io';

import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/screens/login_screen.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:flutter/material.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/styles/my_strings.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:get/get.dart';

class SignupCompleteScreen extends StatefulWidget {
  const SignupCompleteScreen({Key? key}) : super(key: key);

  @override
  _SignupCompleteScreenState createState() => _SignupCompleteScreenState();
}

class _SignupCompleteScreenState extends State<SignupCompleteScreen> {
  _openHomeScreen() {
    //Get.offNamed(MyRouter.loginScreen);
    Get.offAll(LoginScreen());
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
              Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      // margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        'signupCompleted'.tr,
                        style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                            color: MyAppTheme.svdhs,
                            fontFamily: Fonts.biotifSemiBold),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.2,
                    ),
                    MySingleton.shared.socialMediaProfilePci.isNotEmpty
                        ? CircleAvatar(
                            radius: 64.0,
                            backgroundImage: Image.network(
                              MySingleton.shared.socialMediaProfilePci,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ).image,
                          )
                        : CircleAvatar(
                            backgroundColor: MyAppTheme.textWhite,
                            radius: 65,
                            child: CircleAvatar(
                              radius: 64.0,
                              backgroundImage: Image.file(
                                File(MySingleton.shared.image),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ).image,
                            ),
                          ),
                    // Container(
                    //     height: screenSize.height * 0.2,
                    //     width: screenSize.width * 0.4,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //         fit: BoxFit.fill,
                    //         image: NetworkImage(
                    //           MySingleton.shared.socialMediaProfilePci,
                    //         ),
                    //       ),
                    //     ),
                    //   )
                    // : Container(
                    //     height: screenSize.height * 0.2,
                    //     width: screenSize.width * 0.4,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //         fit: BoxFit.fill,
                    //         image: FileImage(
                    //           File(MySingleton.shared.image),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child:
                          LightTextSubHead(data: MySingleton.shared.username),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _openHomeScreen(),
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 35),
                  alignment: Alignment.bottomCenter,
                  child: DarkButton(buttonText: 'loginNow'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
