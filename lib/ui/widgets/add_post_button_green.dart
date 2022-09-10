import 'package:flutter/material.dart';
import '../styles/my_app_theme.dart';
import '../styles/fonts.dart';

class AddPostButtonGreen extends StatelessWidget {
  final String buttonText;

  AddPostButtonGreen({
    required this.buttonText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      height: 45,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: MyAppTheme.gradientColorTop,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: Colors.white,
        // ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
              color: MyAppTheme.textWhite,
              fontSize: 14,
              fontFamily: Fonts.biotifNormal),
        ),
      ),
    );
  }
}
