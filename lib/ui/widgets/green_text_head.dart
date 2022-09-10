import '../styles/my_app_theme.dart';
import 'package:flutter/material.dart';
import '../styles/fonts.dart';

class GreenTextHead extends StatelessWidget {
  final String data;
  const GreenTextHead({required this.data}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyAppTheme.profileText,
            fontFamily: Fonts.biotifSemiBold),
      ),
    );
  }
}
