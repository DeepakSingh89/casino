import 'package:casino/ui/styles/images.dart';
import 'package:flutter/material.dart';
import '../styles/my_app_theme.dart';
import '../styles/fonts.dart';

class AppleButton extends StatelessWidget {
  final String buttonText;

  AppleButton({
    required this.buttonText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 13.0, right: 13.0, top: 13.0),
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyAppTheme.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Image.asset(
              Images.apple,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: MyAppTheme.textWhite,
                  fontSize: 16,
                  fontFamily: Fonts.biotifNormal),
            ),
          ),
        ],
      ),
    );
  }
}
