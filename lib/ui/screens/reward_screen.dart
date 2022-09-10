import 'package:casino/controller/general_controller.dart';
import 'package:casino/model/badge_response.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/reward_head.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  GeneralController _generalController = Get.find();

  @override
  void initState() {
    super.initState();
    _generalController.getBadge(true);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenSize.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyAppTheme.mapGradientColorLast,
                MyAppTheme.mapGradientColorMid,
                MyAppTheme.mapGradientColorTop
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Obx(
            () => _generalController.isLoadingBadge.value
                ? const Loading(
                    loadingMessage: '',
                  )
                : _generalController.badges.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RewardHead(
                              screenSize: screenSize,
                              badges: _generalController.originalBadges),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _generalController.badges.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onTap: () => Get.toNamed(
                                    MyRouter.rewardScreenDetail,
                                    arguments:
                                        _generalController.badges[index]),
                                child: RewardCard(
                                    screenSize: screenSize,
                                    badge: _generalController.badges[index]),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: LightTextHead(
                            data: "noRewardsYou".tr,
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  const RewardCard({
    Key? key,
    required this.screenSize,
    required this.badge,
  }) : super(key: key);

  final Size screenSize;
  final Badge badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
      width: screenSize.width * 0.8,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            Text(
              badge.badgeName,
              style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: MyAppTheme.rewardText,
                  fontFamily: Fonts.biotifNormal),
            ),
            // FadeInImage.assetNetwork(
            //   placeholder: Images.card_reward,
            //   image:
            //       "${Constant.imageURL}${badge.badgePicVersion}/${badge.badgePicId}",
            //   //fit: BoxFit.fill,
            //   height: screenSize.height * 0.3,
            //   width: screenSize.width * 0.4,
            // ),

            Image.network(
              "${Constant.imageURL}${badge.badgePicVersion}/${badge.badgePicId}",
              height: screenSize.height * 0.3,
              width: screenSize.width * 0.4,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
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
          ],
        ),
      ),
    );
  }
}
