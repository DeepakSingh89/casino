import 'package:casino/model/badge_response.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/ui/widgets/yellow_text_body.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:get/get.dart';

class RewardHead extends StatelessWidget {
  const RewardHead({
    Key? key,
    required this.screenSize,
    required this.badges,
  }) : super(key: key);

  final Size screenSize;
  final List<Badge> badges;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 8, left: 8, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: [
                LightTextSubHead(data: "Rewards".tr),
                YellowTextBody(
                    data:
                        "${'NextReward'.tr} ${Utility.getNextBadgeCount(badges)} pts"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: LinearPercentIndicator(
              width: screenSize.width * 0.24,
              animation: true,
              animationDuration: 1000,
              lineHeight: 15.0,
              percent: Utility.getUserRate(),
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: MyAppTheme.gradientColorTop,
              animateFromLastPercent: true,
              backgroundColor: MyAppTheme.gradientColorMid,
            ),
          ),
        ],
      ),
    );
  }
}
