import 'package:casino/ui/styles/images.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Utility.getAdsImageURL().isNotEmpty
        ? GestureDetector(
            onTap: () {
              Utility.launchInBrowser(Utility.getAdsActionUrl());
            },
            child: Container(
              width: screenSize.width,
              child: FadeInImage.assetNetwork(
                placeholder: Images.profile_review_dummy,
                image: Utility.getAdsImageURL(),
                fit: BoxFit.fill,
                width: screenSize.width,
                height: screenSize.height * 0.1,
              ),
            ),
          )
        : Text("");
  }
}
