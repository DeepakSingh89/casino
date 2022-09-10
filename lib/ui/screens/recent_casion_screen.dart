import 'package:casino/model/find_casino.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/profile_card.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentCasionScreen extends StatefulWidget {
  const RecentCasionScreen({Key? key}) : super(key: key);

  @override
  State<RecentCasionScreen> createState() => _RecentCasionScreenState();
}

class _RecentCasionScreenState extends State<RecentCasionScreen> {
  List<CasinoResult> casinoResult = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    casinoResult = Utility.getRecentCasion();
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
                itemCount: casinoResult.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                    onTap: () => Get.toNamed(MyRouter.casionDetailScreen,
                        arguments: casinoResult[index].casinoId),
                     child: ProfileCard(
                     screenSize: screenSize,
                     imageURL:
                        "${Constant.imageURL}${casinoResult[index].picVersion}/${casinoResult[index].picId}",
                     title: casinoResult[index].casinoName,
                     subTitle: casinoResult[index].casinoDiscription,
                     address: casinoResult[index].address.toString(),
                     max: "200",
                     min: "200",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
