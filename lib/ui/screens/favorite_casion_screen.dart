import 'package:casino/model/favorite_casions.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/profile_favorite_list_card.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteCasionScreen extends StatefulWidget {
  const FavoriteCasionScreen({Key? key}) : super(key: key);

  @override
  _FavoriteCasionScreenState createState() => _FavoriteCasionScreenState();
}

class _FavoriteCasionScreenState extends State<FavoriteCasionScreen> {
  late List<FavouriteList> favouriteList = List<FavouriteList>.empty();
  String meter = "";
  @override
  void initState() {
    favouriteList = Get.arguments;
    super.initState();
  }

  display(FavouriteList favouriteList) {
    // try {
    //   Utility.getCurrentLatLong().then((value) {
    //     var lat = value.latitude;
    //     var long = value.longitude;
    //     setState(() {
    //       meter =
    //           "${Utility.getDistanceBetween(lat, long, favouriteList.location[0], favouriteList.location[1])}} ${'meterAway'.tr}";
    //     });
    //   });
    // } catch (e) {
    //   print(e.toString());
    // }
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
                itemCount: favouriteList.length,
                itemBuilder: (BuildContext context, int index) =>
                    ProfileFavoriteListCard(
                  screenSize: screenSize,
                  imageURL:
                      "${Constant.imageURL}${favouriteList[index].picVersion}/${favouriteList[index].picId}",
                  title: favouriteList[index].casinoName,
                  subTitle: favouriteList[index].casinoDiscription,
                  address: "",
                  max: "",
                  min: "200",
                  distance: meter,
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
