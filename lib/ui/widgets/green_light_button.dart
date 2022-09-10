import 'package:flutter/material.dart';
import '../styles/my_app_theme.dart';
import '../styles/fonts.dart';

class GreenLightButton extends StatelessWidget {
  final String buttonText;

  GreenLightButton({
    required this.buttonText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyAppTheme.darkButtonColor,
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
