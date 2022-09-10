import 'package:casino/controller/community_controller.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/add_post_button_green.dart';
import 'package:casino/ui/widgets/community_card.dart';
import 'package:casino/ui/widgets/review/community_custom_dialog_box.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityController _communityController =
      Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.communityBackground,
        body: Column(
          children: [
            ProfileHead(
              isBackArrow: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CasinoForums".tr,
                        style: const TextStyle(
                            color: MyAppTheme.casinoForums,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CommunityCustomDialogBox(
                            screenSize_: screenSize,
                          );
                        }),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddPostButtonGreen(
                        buttonText: "AddPost".tr,
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   width: screenSize.width * 0.1,
                  // ),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Icon(
                  //     Icons.camera_alt_rounded,
                  //     color: Colors.black,
                  //     size: 30.0,
                  //     textDirection: TextDirection.ltr,
                  //     semanticLabel:
                  //         'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                  //   ),
                  // ),
                ],
              ),
            ),
            Obx(
              () => _communityController.isLoading.value
                  ? const Loading(
                      loadingMessage: '',
                    )
                  : _communityController.forums.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: ListView.builder(
                              itemCount: _communityController.forums.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  CommunityCard(
                                      screenSize: screenSize,
                                      forums:
                                          _communityController.forums[index],
                                      communityController:
                                          _communityController),
                            ),
                          ),
                        )
                      : Text("noData".tr),
            )
          ],
        ),
      ),
    );
  }
}
