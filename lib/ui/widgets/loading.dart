import '../styles/my_app_theme.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({required this.loadingMessage}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(MyAppTheme.gradientColorTop),
      ),
    );
  }
}
