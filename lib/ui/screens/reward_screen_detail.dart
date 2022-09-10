import 'package:casino/model/badge_response.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/green_light_button.dart';
import 'package:casino/ui/widgets/green_lighter_button.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardScreenDetail extends StatefulWidget {
  const RewardScreenDetail({Key? key}) : super(key: key);

  @override
  _RewardScreenDetailState createState() => _RewardScreenDetailState();
}

class _RewardScreenDetailState extends State<RewardScreenDetail> {
  late Badge badge;

  @override
  void initState() {
    super.initState();
    badge = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.04),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "YouEarnedReward".tr,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.04),
                FadeInImage.assetNetwork(
                  placeholder: Images.card_reward,
                  image:
                      "${Constant.imageURL}${badge.badgePicVersion}/${badge.badgePicId}",
                  //fit: BoxFit.fill,
                  height: screenSize.height * 0.3,
                  width: screenSize.width * 0.4,
                ),
                Text(
                  badge.badgeName,
                  style: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: MyAppTheme.rewardText,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, bottom: 20, top: 20),
                  child: Center(
                    child: Text(
                      badge.badgeDiscription,
                      style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: MyAppTheme.black,
                          fontFamily: Fonts.biotifNormal),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.18,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, bottom: 20, top: 20),
                    child: GreenLightButton(
                      buttonText: "continue".tr,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
