import 'dart:async';

import 'package:casino/controller/map_controller.dart';
import 'package:casino/ui/widgets/green_lighter_button.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRangeDialogBox extends StatefulWidget {
  const MapRangeDialogBox({Key? key, required this.googleMapController})
      : super(key: key);

  final Completer<GoogleMapController> googleMapController;

  @override
  State<MapRangeDialogBox> createState() => _MapRangeDialogBoxState();
}

class _MapRangeDialogBoxState extends State<MapRangeDialogBox> {
  final _formKey = GlobalKey<FormState>();

  int valueHolder = 10;
  late String _darkMapStyle;
  final MapController _mapController = Get.put(MapController());
  _loadMapStyles() {
    _darkMapStyle = Constant.googleMapDark;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    valueHolder = Utility.getRadius();
  }

  Future _setMapStyle() async {
    _loadMapStyles();
    final controller = await widget.googleMapController.future;
    controller.setMapStyle(_darkMapStyle);
  }

  void _applyRange(context, int valueHolder) {
    Navigator.pop(context, false);
    print(" _applyRange() ${valueHolder}");
    Utility.saveRadius(valueHolder);
    var miles = Utility.convertIntoMile(valueHolder);
    _mapController.initRange.value = miles;
    _mapController.currentLogLat(miles);

    setState(() {
      _setMapStyle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constant.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                //left: Constant.padding,
                top: 20,
                //right: Constant.padding,
                bottom: Constant.padding),
            margin: const EdgeInsets.only(top: Constant.avatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: MyAppTheme.textWhite,
              borderRadius: BorderRadius.circular(Constant.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  //height: doub,

                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "setRadius".tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              color: MyAppTheme.textColor_,
                              fontFamily: Fonts.biotifSemiBold),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(20),
                          child: Slider(
                              value: valueHolder.toDouble(),
                              min: 1,
                              max: 100,
                              divisions: 99,
                              activeColor: Colors.green,
                              inactiveColor: Colors.grey,
                              label: '${valueHolder.round()}',
                              onChanged: (double newValue) {
                                setState(() {
                                  valueHolder = newValue.round();
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()}';
                              })),
                      Text(
                        '$valueHolder',
                        style: TextStyle(fontSize: 22),
                      ),
                      GestureDetector(
                        onTap: () => _applyRange(context, valueHolder),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GreenLighterButton(buttonText: "Apply".tr),
                        ),
                      )
                    ],
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
