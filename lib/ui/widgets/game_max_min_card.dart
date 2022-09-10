import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';

class GameMaxMinCard extends StatelessWidget {
  const GameMaxMinCard({
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
      padding: const EdgeInsets.only(right: 12, left: 12),
      margin: const EdgeInsets.only(top: 10),
      height: screenSize.height * 0.04,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: MyAppTheme.profileCardMaxMin,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Min:'),
                  TextSpan(
                    text: " \$${min}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyAppTheme.profileCardMin,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Max:'),
                  TextSpan(
                    text: " \$${max} ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyAppTheme.profileCardMin,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
