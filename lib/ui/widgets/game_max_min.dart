import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';

class GameMaxMin extends StatelessWidget {
  const GameMaxMin({
    Key? key,
    required this.screenSize,
    required this.max,
    required this.min,
  }) : super(key: key);

  final Size screenSize;
  final String max, min;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      height: screenSize.height * 0.04,
      width: screenSize.width * 0.4,
      decoration: const BoxDecoration(
        color: MyAppTheme.profileCardMaxMin,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Min:'),
                  TextSpan(
                    text: " \$${min} ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyAppTheme.profileCardMin,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
                children: [
                  const TextSpan(text: 'Max:'),
                  TextSpan(
                    text: " \$${max}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyAppTheme.profileCardMin,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
