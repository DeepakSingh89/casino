import '../styles/my_app_theme.dart';
import 'package:flutter/material.dart';
import '../styles/fonts.dart';

class GreenTextSubHead extends StatelessWidget {
  final String data;
  const GreenTextSubHead({required this.data}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: MyAppTheme.communtiyGreenCard,
            fontFamily: Fonts.biotifSemiBold),
      ),
    );
  }
}
