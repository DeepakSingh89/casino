import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading.dart';

class ProfileTopRatingBadge extends StatefulWidget {
  const ProfileTopRatingBadge({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  State<ProfileTopRatingBadge> createState() => _ProfileTopRatingBadgeState();
}

class _ProfileTopRatingBadgeState extends State<ProfileTopRatingBadge> {
  GeneralController _generalController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalController.getBadge(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MyAppTheme.profileGradientRaitingStart,
            MyAppTheme.profileGradientRaitingEnd
          ],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ),
      ),
      height: widget.screenSize.height * 0.05,
      width: double.infinity,
      child: Center(
        child: Obx(
          () => _generalController.isLoadingBadge.value
              ? const Loading(
                  loadingMessage: '',
                )
              : RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              ' ${Utility.getNextBadgeCount(_generalController.originalBadges)} ${'moreRatingsfor'.tr} '),
                      TextSpan(
                        text: 'RaterBadge'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyAppTheme.profileRatingYellow,
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
