import 'package:casino/model/find_casino.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/ui/widgets/profile_card.dart';
import 'package:casino/ui/widgets/profile_review_top_sea_all.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentCasionList extends StatefulWidget {
  const RecentCasionList({
    Key? key,
    required this.screenSize,
  }) : super(key: key);
  final Size screenSize;

  @override
  State<RecentCasionList> createState() => _RecentCasionListState();
}

class _RecentCasionListState extends State<RecentCasionList> {
  List<CasinoResult> casinoResult = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    casinoResult = Utility.getRecentCasion();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (casinoResult.isNotEmpty) {
              Get.toNamed(MyRouter.recentCasionScreen);
            }
          },
          child: ProfileReviewTopSeaAll(
            screenSize: widget.screenSize,
            title: "RecentCasinos".tr,
            isVisiable: casinoResult.isNotEmpty ? true : false,
          ),
        ),
        casinoResult.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: LightTextSubHead(data: "noData".tr),
              )
            : GestureDetector(
                onTap: () => Get.toNamed(MyRouter.casionDetailScreen,
                    arguments: casinoResult[0].casinoId),
                child: ProfileCard(
                  screenSize: widget.screenSize,
                  imageURL:
                      "${Constant.imageURL}${casinoResult[0].picVersion}/${casinoResult[0].picId}",
                  title: casinoResult[0].casinoName,
                  subTitle: casinoResult[0].casinoDiscription,
                  address: casinoResult[0].address.toString(),
                  max: "200",
                  min: "200",
                ),
              ),
      ],
    );
  }
}
