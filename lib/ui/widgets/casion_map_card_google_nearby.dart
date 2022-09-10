import 'dart:developer';
import 'package:casino/model/find_casino.dart';
import 'package:casino/model/google_nearby.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CasionMapCardGooleNearby extends StatefulWidget {
  const CasionMapCardGooleNearby({
    Key? key,
    required this.screenSize,
    required this.result,
  }) : super(key: key);

  final Size screenSize;
  final Results result;

  @override
  State<CasionMapCardGooleNearby> createState() =>
      _CasionMapCardGooleNearbyState();
}

class _CasionMapCardGooleNearbyState extends State<CasionMapCardGooleNearby> {
  String meter = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    display();
  }

  display() {
    Utility.getCurrentLatLong().then((value) {
      var lat = double.parse((value.latitude).toStringAsFixed(4));
      var long = double.parse((value.longitude).toStringAsFixed(4));
      setState(() {
        meter =
            "${Utility.getDistanceBetween(lat, long, widget.result.geometry.location.lat, widget.result.geometry.location.lng)} ${'meterAway'.tr}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyAppTheme.cardSerachResult,
      elevation: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: widget.screenSize.width * 0.3,
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 5,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Utility.getGoogleImage(widget.result).isEmpty
                  ? Image.asset(
                      Images.logo,
                      width: widget.screenSize.width * 0.25,
                      height: widget.screenSize.height * 0.12,
                    )
                  : FadeInImage.assetNetwork(
                      placeholder: Images.logo,
                      image: "${Utility.getGoogleImage(widget.result)}",
                      fit: BoxFit.fill,
                      width: widget.screenSize.width * 0.25,
                      height: widget.screenSize.height * 0.12,
                    ),
            ),
          ),
          SizedBox(
            width: widget.screenSize.width * 0.018,
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            width: widget.screenSize.width * 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.result.name,
                  style: const TextStyle(
                      color: MyAppTheme.profileCardTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    meter,
                    style: const TextStyle(
                        color: MyAppTheme.profileCardSubTitle, fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: widget.screenSize.width * 0.6,
                  height: widget.screenSize.height * 0.048,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
