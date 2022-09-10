import 'dart:developer';

import 'package:casino/controller/community_controller.dart';
import 'package:casino/model/casino_forum_response.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/green_text_sub_head.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CommunityCard extends StatelessWidget {
  CommunityCard(
      {Key? key,
      required this.screenSize,
      required this.forums,
      required this.communityController})
      : super(key: key);

  final Size screenSize;
  final Forums forums;
  final CommunityController communityController;
  List imgList = [];

  items(BuildContext context, Size screenSize) {
    for (var element in forums.casinoForumImage) {
      var url = "${Constant.imageURL}${element.picVersion}/${element.picId}";
      //log("url : ${url}");
      imgList.add(url);
    }

    return imgList.map((element) {
      return Builder(
        builder: (BuildContext context) {
          return FadeInImage.assetNetwork(
            placeholder: Images.profile_review_dummy,
            image: element,
            fit: BoxFit.fill,
            width: screenSize.width,
            height: screenSize.height * 0.12,
          );
        },
      );
    }).toList();
  }

  isLike() {
    var isLike = false;
    for (var element in forums.forumLikes) {
      if (element.userId == Utility.getUserID()) {
        isLike = true;
        break;
      }
    }
    return isLike;
  }

  removeLike() {
    communityController
        .removeLike(forums.casinoForumId, Utility.getUserID())
        .then((value) {
      if (value) {
        communityController.getCoummunity();
      }
    });
  }

  addLike() {
    communityController
        .addLike(forums.casinoForumId, Utility.getUserID())
        .then((value) {
      if (value) {
        communityController.getCoummunity();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: screenSize.width,
      //height: screenSize.height * 0.43,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: GreenTextSubHead(data: forums.casinoForumName),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 4, left: 8),
              //   child: Icon(
              //     Icons.info_sharp,
              //     color: MyAppTheme.infoColor,
              //     size: 30.0,
              //     textDirection: TextDirection.ltr,
              //     semanticLabel:
              //         'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
              //   ),
              // ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 2, left: 8, bottom: 25),
            child: Text(
              forums.casinoForumDiscription,
              style: const TextStyle(
                fontSize: 12,
                color: MyAppTheme.communtiySubTitleCard,
              ),
            ),
          ),
          Stack(
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: CarouselSlider(
                  items: items(context, screenSize),
                  options: CarouselOptions(
                    disableCenter: true,
                    height: screenSize.height * 0.25,
                    aspectRatio: 1.5,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 160,
                child: Row(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundColor: MyAppTheme.pinCircleColor,
                          radius: 20,
                          child: CircleAvatar(
                            radius: 19.0,
                            backgroundImage: Image.network(
                              "${Constant.imageURL}${forums.userPicVersion}/${forums.userPicId}",
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      height: screenSize.height * 0.04,
                      // width: screenSize.width * 0.25,
                      decoration: const BoxDecoration(
                        color: MyAppTheme.pinCircleColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          forums.userName,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Image.asset(Images.llkes),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${forums.numberOfLike} ${'Likes'.tr}",
                        style: const TextStyle(color: MyAppTheme.textLikeColor),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    isLike()
                        ? GestureDetector(
                            onTap: () => removeLike(),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Icon(
                                Icons.thumb_up_sharp,
                                color: Colors.blueAccent,
                                size: 30,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => addLike(),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Icon(
                                Icons.thumb_up_sharp,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                          ),
                    GestureDetector(
                      onTap: () => Get.toNamed(MyRouter.forumCommentScreen,
                          arguments: forums),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Image.asset(Images.noun_comment),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Image.asset(Images.Icon_awesome_share_alt),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
        ],
      ),
    );
  }
}
