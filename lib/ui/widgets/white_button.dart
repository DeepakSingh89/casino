import 'package:flutter/material.dart';
import '../styles/my_app_theme.dart';
import '../styles/fonts.dart';

class WhiteButton extends StatelessWidget {
  final String buttonText;

  WhiteButton({
    required this.buttonText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 13.0, right: 13.0, top: 13.0),
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: MyAppTheme.textWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
              color: MyAppTheme.black,
              fontSize: 16,
              fontFamily: Fonts.biotifNormal),
        ),
      ),
    );
  }
}
