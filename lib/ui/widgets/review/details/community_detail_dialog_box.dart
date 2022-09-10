import 'package:casino/model/get_forum_review.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:casino/model/restaurant_review_response.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommunityDetailDialogBox extends StatefulWidget {
  const CommunityDetailDialogBox({Key? key, required this.hotelDataForumReview})
      : super(key: key);
  final HotelData hotelDataForumReview;
  @override
  _CommunityDetailDialogBoxState createState() =>
      _CommunityDetailDialogBoxState();
}

class _CommunityDetailDialogBoxState extends State<CommunityDetailDialogBox> {
  List imgList = [];

  items(BuildContext context, Size screenSize) {
    for (var element in widget.hotelDataForumReview.forumReviewImage) {
      var url = "${Constant.imageURL}${element.picVersion}/${element.picId}";
      imgList.add(url);
    }

    return imgList.map((element) {
      return Builder(
        builder: (BuildContext context) {
          return FadeInImage.assetNetwork(
            placeholder: Images.profile_review_dummy,
            image: element,
            // fit: BoxFit.fill,
            // width: screenSize.width,
            // height: screenSize.height * 0.12,
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constant.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            // height: screenSize.height * 0.55,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, bottom: Constant.padding),
            margin: const EdgeInsets.only(top: Constant.avatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: MyAppTheme.textWhite,
              borderRadius: BorderRadius.circular(Constant.padding),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.hotelDataForumReview.casinoName,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: MyAppTheme.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    initialRating:
                        widget.hotelDataForumReview.rating.toDouble(),
                    minRating: widget.hotelDataForumReview.rating.toDouble(),
                    updateOnDrag: false,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    tapOnlyMode: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 30.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.2),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.05,
                        child: CircleAvatar(
                          backgroundColor: MyAppTheme.textWhite,
                          radius: 20,
                          child: CircleAvatar(
                            radius: 19.0,
                            backgroundImage: Image.network(
                              Utility.getImageUrl(
                                  widget.hotelDataForumReview.userPicId,
                                  widget.hotelDataForumReview.userPicVersion),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.hotelDataForumReview.review,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: MyAppTheme.black,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                widget.hotelDataForumReview.forumReviewImage.isEmpty
                    ? Text("")
                    : Container(
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
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            left: 35,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: MyAppTheme.gradientColorMid,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
