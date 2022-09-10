import '../styles/fonts.dart';
import '../styles/my_app_theme.dart';
import 'package:flutter/material.dart';

class YellowTextBody extends StatelessWidget {
  final String data;
  const YellowTextBody({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 12,
            color: MyAppTheme.ratingCol,
            fontFamily: Fonts.biotifNormal),
      ),
    );
  }
}
