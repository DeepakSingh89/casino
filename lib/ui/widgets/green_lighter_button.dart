import 'package:flutter/material.dart';
import '../styles/my_app_theme.dart';
import '../styles/fonts.dart';

class GreenLighterButton extends StatelessWidget {
  final String buttonText;

  GreenLighterButton({
    required this.buttonText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 13.0, right: 13.0, top: 13.0),
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyAppTheme.testq,
        borderRadius: BorderRadius.circular(30),
        // border: Border.all(
        //   color: Colors.white,
        // ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
              color: MyAppTheme.textWhite,
              fontSize: 16,
              fontFamily: Fonts.biotifNormal),
        ),
      ),
    );
  }
}
