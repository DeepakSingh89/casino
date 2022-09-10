import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    required this.screenSize,
    required this.title,
    required this.date,
    required this.subTitle,
    required this.imageURL,
    required this.rate,
  }) : super(key: key);

  final Size screenSize;
  final String title, date, subTitle, imageURL;
  final int rate;

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
                )
                // CircleAvatar(
                //   radius: 20.0,
                //   child: ClipRRect(
                //     child: FadeInImage.assetNetwork(
                //       placeholder: Images.profile_review_dummy,
                //       image: imageURL,
                //       fit: BoxFit.fill,
                //       width: screenSize.width * 0.25,
                //       height: screenSize.height * 0.12,
                //     ),
                //     borderRadius: BorderRadius.circular(50.0),
                //   ),
                // ),
                ),
            title: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(fontSize: 15.0),
              text: TextSpan(
                  style: const TextStyle(
                    color: MyAppTheme.textWhite,
                  ),
                  text: title),
            ),
            trailing: LightTextBody(
              data: date,
            ),
            subtitle: SizedBox(
              width: screenSize.width * 0.6,
              child: Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(5.0),
            isThreeLine: false,
          ),
          Container(
            margin: const EdgeInsets.only(right: 5, bottom: 5),
            alignment: Alignment.bottomRight,
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
        ],
      ),

      // ReviewCard(
      //     screenSize: screenSize,
      //     imageURL: imageURL,
      //     title: title,
      //     rate: rate,
      //     date: date,
      //     subTitle: subTitle),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.screenSize,
    required this.imageURL,
    required this.title,
    required this.rate,
    required this.date,
    required this.subTitle,
  }) : super(key: key);

  final Size screenSize;
  final String imageURL;
  final String title;
  final int rate;
  final String date;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                  //width: screenSize.width * 0.4,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.profile_review_dummy,
                        image: imageURL,
                        fit: BoxFit.fill,
                        width: screenSize.width * 0.25,
                        height: screenSize.height * 0.12,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                strutStyle: const StrutStyle(fontSize: 15.0),
                text: TextSpan(
                    style: const TextStyle(
                      color: MyAppTheme.textWhite,
                    ),
                    text: title),
              ),
            ),
            RatingBar.builder(
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
              onRatingUpdate: (rating) {
                print(rating);
                //ratingValue = rating;
              },
            ),
            SizedBox(
              width: screenSize.width * 0.02,
            ),
            LightTextBody(
              data: date,
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 40),
          width: screenSize.width * 0.8,
          child: Text(
            subTitle,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
