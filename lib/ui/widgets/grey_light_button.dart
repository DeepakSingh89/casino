import 'package:flutter/material.dart';
import '../styles/my_app_theme.dart';
import '../styles/fonts.dart';

class GreyLightButton extends StatelessWidget {
  final String buttonText;

  GreyLightButton({
    required this.buttonText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 13.0, right: 13.0, top: 13.0),
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(30),
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
