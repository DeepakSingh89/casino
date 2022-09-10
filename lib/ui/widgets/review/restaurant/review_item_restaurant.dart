import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/model/restaurant_review_response.dart';

import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/review/restaurant/add_restaurant_star_dialog_box_direct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ReviewItemRestaurant extends StatelessWidget {
  const ReviewItemRestaurant(
      {Key? key,
      required this.screenSize,
      required this.title,
      required this.date,
      required this.subTitle,
      required this.imageURL,
      required this.rate,
      required this.restaurantReviewResponsehotelData,
      required this.casinoDetail})
      : super(key: key);

  final Size screenSize;
  final String title, date, subTitle, imageURL;
  final int rate;
  final RestaurantData restaurantReviewResponsehotelData;
  final CasinoDetails casinoDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: SizedBox(
                height: screenSize.height * 0.05,
                //width: screenSize.width * 0.4,
                child: CircleAvatar(
                  backgroundColor: MyAppTheme.textWhite,
                  radius: 20,
                  child: CircleAvatar(
                    radius: 19.0,
                    backgroundImage: Image.network(
                      imageURL,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ).image,
                  ),
                )),
            title: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(fontSize: 15.0),
              text: TextSpan(
                  style: const TextStyle(
                    color: MyAppTheme.textWhite,
                  ),
                  text: title),
            ),
            trailing: Container(
              width: screenSize.width * 0.3,
              //  margin: const EdgeInsets.only(right: 5, bottom: 5),
              //alignment: Alignment.bottomRight,
              child: RatingBar.builder(
                initialRating: rate.toDouble(),
                minRating: rate.toDouble(),
                updateOnDrag: false,
                direction: Axis.horizontal,
                allowHalfRating: false,
                tapOnlyMode: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 20.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.2),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ),

            subtitle: SizedBox(
              width: screenSize.width * 0.6,
              child: Text(
                restaurantReviewResponsehotelData.restaurantLocation,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            //contentPadding: const EdgeInsets.all(5.0),
            //isThreeLine: false,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddRestaurantStarDialogBoxDirect(
                      casinoDetail: casinoDetail,
                      restaurantReviewResponsehotelData:
                          restaurantReviewResponsehotelData,
                      address:
                          restaurantReviewResponsehotelData.restaurantLocation,
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20, bottom: 10),
              alignment: Alignment.bottomRight,
              child: Text(
                "ADDREVIEW".tr,
                style: const TextStyle(
                  color: MyAppTheme.gradientColorTop,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
