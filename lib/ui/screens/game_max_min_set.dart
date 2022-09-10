import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/add_post_button_green.dart';
import 'package:casino/ui/widgets/casion_button_green.dart';
import 'package:casino/ui/widgets/game_max_min_card.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameMaxMinSet extends StatefulWidget {
  const GameMaxMinSet({Key? key}) : super(key: key);

  @override
  _GameMaxMinSetState createState() => _GameMaxMinSetState();
}

class _GameMaxMinSetState extends State<GameMaxMinSet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late var casinoId;
  late var gameModeId;

  late var maxBetSize;
  late var minBetSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    var getArg = Get.arguments;
    casinoId = getArg[0];
    gameModeId = getArg[1];
    maxBetSize = getArg[2];
    minBetSize = getArg[3];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyAppTheme.mapGradientColorLast,
                //  MyAppTheme.mapGradientColorMid,
                MyAppTheme.mapGradientColorTop
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                  alignment: Alignment.topLeft,
                  child: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 40),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              LightTextBody(
                data: 'editTable'.tr,
              ),
              SizedBox(
                height: screenSize.height * 0.08,
              ),
              Image.asset(
                Images.game_card,
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.22,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.6,
                    child: GameMaxMinCard(
                        screenSize: screenSize,
                        max: maxBetSize,
                        min: minBetSize),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              GestureDetector(
                onTap: () => Get.toNamed(MyRouter.gameMAxMinSetComplete,
                    arguments: [casinoId, gameModeId, maxBetSize, minBetSize]),
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 50.0, right: 50.0, top: 40),
                  //  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  height: 50,
                  decoration: BoxDecoration(
                    color: MyAppTheme.gradientColorTop,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "YES".tr,
                      style: const TextStyle(
                          color: MyAppTheme.textWhite,
                          fontSize: 14,
                          fontFamily: Fonts.biotifNormal),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              GestureDetector(
                  onTap: () => Get.back(),
                  child: LightTextSubHead(data: "NO".tr)),
            ],
          ),
        ),
      ),
    );
  }
}
