import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.backgroundBlack,
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 15),
                  child: LightTextHead(data: "Settings"),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
