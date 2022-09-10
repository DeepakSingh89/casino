import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'light_text_body.dart';

class UserRateRewardTop extends StatelessWidget {
  const UserRateRewardTop({
    Key? key,
    required this.screenSize,
  }) : super(key: key);
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.1,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  height: screenSize.height * 0.09,
                  child: CircleAvatar(
                    backgroundColor: MyAppTheme.textWhite,
                    radius: 36,
                    child: CircleAvatar(
                      radius: 34.0,
                      backgroundImage: Image.network(
                        "${Constant.imageURL}${Utility.getUserProfile()}",
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ).image,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 4),
                child: RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: Utility.getUserName().toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      // TextSpan(
                      //   text: "\nRating ${Utility.getUserRate()} of 5",
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: MyAppTheme.profileRatingYellow,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // SizedBox(
          //   width: screenSize.width * 0.15,
          // ),
          GestureDetector(
            onTap: () => Get.toNamed(MyRouter.rewardScreen),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 3),
                  child: SizedBox(
                      width: screenSize.width * 0.34,
                      child: Text(
                        "viewRewards".tr,
                        style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: MyAppTheme.textWhite,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                LinearPercentIndicator(
                  width: screenSize.width * 0.365,
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 15.0,
                  percent: Utility.getUserRate(),
                  linearStrokeCap: LinearStrokeCap.butt,
                  progressColor: MyAppTheme.gradientColorTop,
                  animateFromLastPercent: true,
                  backgroundColor: MyAppTheme.gradientColorMid,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
