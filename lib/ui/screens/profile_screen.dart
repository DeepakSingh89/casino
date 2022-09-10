import 'package:casino/controller/casion_controller.dart';
import 'package:casino/controller/general_controller.dart';
import 'package:casino/controller/review_controller.dart';
import 'package:casino/ui/screens/profile_list.dart';
import 'package:casino/ui/widgets/my_banner.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/ui/widgets/profile_pic_reward.dart';
import 'package:casino/ui/widgets/profile_top_rating_badge.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ReviewController _reviewController = Get.find();
  final CasionController _casionController = Get.find();

  @override
  void initState() {
    super.initState();
    var userId = Utility.getUserID();
    _reviewController.getCasionReviewByUserId(userId);
    _casionController.getFavoriteCasinoDetails(userId);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ProfileHead(
              isBackArrow: false,
            ),
            ProfileTopRatingBadge(screenSize: screenSize),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 200),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    MyBanner(screenSize: screenSize),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    ProfilePicReward(screenSize: screenSize),
                    SizedBox(
                      height: screenSize.height * 0.05,
                    ),
                    ProfileList(screenSize: screenSize),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
