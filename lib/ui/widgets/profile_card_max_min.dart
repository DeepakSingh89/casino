import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCardMaxMin extends StatelessWidget {
  const ProfileCardMaxMin({
    Key? key,
    required this.screenSize,
    required this.max,
    required this.min,
  }) : super(key: key);

  final Size screenSize;
  final String max, min;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      height: screenSize.height * 0.04,
      width: screenSize.width * 0.5,
      decoration: const BoxDecoration(
        color: MyAppTheme.profileCardMaxMin,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(text: '${'Min'.tr}:'),
                TextSpan(
                  text: " \$${max}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyAppTheme.profileCardMin,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(text: '${'Max'.tr}:'),
                TextSpan(
                  text: " \$${min} ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyAppTheme.profileCardMin,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
