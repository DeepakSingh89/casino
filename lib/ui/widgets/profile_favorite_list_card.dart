import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';

class ProfileFavoriteListCard extends StatelessWidget {
  const ProfileFavoriteListCard({
    Key? key,
    required this.screenSize,
    required this.imageURL,
    required this.title,
    required this.subTitle,
    required this.address,
    required this.max,
    required this.min,
    required this.distance,
  }) : super(key: key);

  final Size screenSize;
  final String imageURL;
  final String title;
  final String subTitle;
  final String address;
  final String max;
  final String min;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: screenSize.height * 0.2,
      width: screenSize.width * 0.98,
      //  color: MyAppTheme.profileCard,
      child: Card(
        color: MyAppTheme.profileCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.profile_review_dummy,
                    image: imageURL,
                    fit: BoxFit.cover,
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.02,
            ),
            Container(
              width: screenSize.width * 0.45,
              margin: const EdgeInsets.only(top: 15, right: 14),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        color: MyAppTheme.profileCardTitle, fontSize: 18),
                  ),

                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      strutStyle: const StrutStyle(fontSize: 15.0),
                      softWrap: true,
                      text: TextSpan(
                          style: const TextStyle(
                            color: MyAppTheme.profileCardSubTitle,
                          ),
                          text: subTitle),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 6),
                  //   child: Text(
                  //     subTitle,
                  //     style: const TextStyle(
                  //         color: MyAppTheme.profileCardSubTitle,
                  //         fontSize: 15),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      address,
                      style: const TextStyle(
                          color: MyAppTheme.profileCardSubtoSubTitle,
                          fontSize: 12),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 25),
                  //   child: Text(
                  //     distance,
                  //     style: const TextStyle(
                  //         color: MyAppTheme.profileCardSubtoSubTitle,
                  //         fontSize: 12),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(Images.heart,color: Colors.red,),
            )
          ],
        ),
      ),
    );
  }
}
