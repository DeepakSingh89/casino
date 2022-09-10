import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/ui/widgets/review_item.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:casino/model/casino_user_review_rating.dart'
    as CasinoUserReviewRating;

class CasionUserReviewScreen extends StatefulWidget {
  const CasionUserReviewScreen({Key? key}) : super(key: key);

  @override
  _CasionUserReviewScreenState createState() => _CasionUserReviewScreenState();
}

class _CasionUserReviewScreenState extends State<CasionUserReviewScreen> {
  late List<CasinoUserReviewRating.CasinoData> casinoDatas =
      List<CasinoUserReviewRating.CasinoData>.empty();
  @override
  void initState() {
    casinoDatas = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.mapGradientColorLast,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ProfileHead(
              isBackArrow: true,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: casinoDatas.length,
                itemBuilder: (BuildContext context, int index) => ReviewItem(
                  screenSize: screenSize,
                  title: casinoDatas[index].casinoName,
                  date: Utility.getDate(casinoDatas[index].createdDate),
                  subTitle: casinoDatas[index].review,
                  imageURL:
                      "${Constant.imageURL}${casinoDatas[index].userPicVersion}/${casinoDatas[index].userPicId}",
                  rate: casinoDatas[index].rating,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
