import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';

import 'light_text_body.dart';

class CovidInfo extends StatelessWidget {
  const CovidInfo({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 2,
        backgroundColor: MyAppTheme.textWhite,
      ),
      title: LightTextBody(data: title),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
