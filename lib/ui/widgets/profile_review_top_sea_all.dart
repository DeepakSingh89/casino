import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/green_text_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileReviewTopSeaAll extends StatelessWidget {
  const ProfileReviewTopSeaAll({
    Key? key,
    required this.screenSize,
    required this.title,
    required this.isVisiable,
  }) : super(key: key);

  final Size screenSize;
  final String title;
  final bool isVisiable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GreenTextHead(
            data: title,
          ),
        ),
        isVisiable
            ? Container(
                height: screenSize.height * 0.04,
                width: screenSize.width * 0.25,
                decoration: const BoxDecoration(
                  color: MyAppTheme.darkSeeAll,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'SEEALL'.tr,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : const Text(""),
      ],
    );
  }
}
