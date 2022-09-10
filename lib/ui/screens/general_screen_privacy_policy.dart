import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralScreenPrivacyPolicy extends StatefulWidget {
  const GeneralScreenPrivacyPolicy({
    Key? key,
  }) : super(key: key);

  @override
  State<GeneralScreenPrivacyPolicy> createState() =>
      _GeneralScreenPrivacyPolicyState();
}

class _GeneralScreenPrivacyPolicyState
    extends State<GeneralScreenPrivacyPolicy> {
  final GeneralController _generalController = Get.find();
  @override
  void initState() {
    super.initState();
    _generalController.getStaticPage();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.backgroundBlack,
        body: Column(
          children: [
            Container(
              height: screenSize.height * 0.08,
              margin: const EdgeInsets.only(right: 20, left: 20, top: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white)),
                  LightTextHead(data: "privacyPolicy".tr),
                  SizedBox(
                    width: screenSize.width * 0.05,
                  ),
                ],
              ),
            ),
            Obx(
              () => _generalController.isLoading.value
                  ? const Loading(
                      loadingMessage: '',
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            _generalController
                                .staticPageData[0].termAndCondition,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
