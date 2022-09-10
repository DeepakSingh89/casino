import 'dart:developer';
import 'package:casino/model/find_casino.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CasionMapCard extends StatefulWidget {
  const CasionMapCard({
    Key? key,
    required this.screenSize,
    required this.casinoResult,
  }) : super(key: key);

  final Size screenSize;
  final CasinoResult casinoResult;

  @override
  State<CasionMapCard> createState() => _CasionMapCardState();
}

class _CasionMapCardState extends State<CasionMapCard> {
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
            "${Utility.getDistanceBetween(lat, long, widget.casinoResult.location[1], widget.casinoResult.location[0])} ${'meterAway'.tr}";
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
              child: FadeInImage.assetNetwork(
                placeholder: Images.profile_review_dummy,
                image:
                    "${Constant.imageURL}${widget.casinoResult.picVersion}/${widget.casinoResult.picId}",
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.casinoResult.casinoName,
                      style: const TextStyle(
                          color: MyAppTheme.profileCardTitle,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Utility.getDate(widget.casinoResult.created),
                      style: const TextStyle(
                          color: MyAppTheme.textWhite, fontSize: 10),
                    ),
                  ],
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
                  child: Text(
                    widget.casinoResult.casinoDiscription,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
