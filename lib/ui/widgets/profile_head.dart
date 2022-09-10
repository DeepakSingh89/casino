import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHead extends StatefulWidget {
  ProfileHead({
    Key? key,
    required this.isBackArrow,
  }) : super(key: key);

  final bool isBackArrow;

  @override
  State<ProfileHead> createState() => _ProfileHeadState();
}

class _ProfileHeadState extends State<ProfileHead> {
  final GeneralController _generalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyAppTheme.gradientColorTop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          widget.isBackArrow
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _generalController.showCovid.value = false;
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white, size: 35),
                    ),
                    Image.asset(Images.casion_table_report)
                  ],
                )
              : Container(
                  child: Image.asset(Images.casion_table_report),
                ),
          Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                child:
                    //LightTextBody(   data: "${'WelcomeBack'.tr},\n${Utility.getUserName()}!"),

                    RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "${'WelcomeBack'.tr}"),
                      TextSpan(
                        text: "\n${Utility.getUserName()}!",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyAppTheme.textWhite,
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
