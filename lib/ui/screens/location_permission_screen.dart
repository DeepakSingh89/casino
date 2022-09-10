import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_strings.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../ui/styles/my_app_theme.dart';
import '../../ui/styles/locale_string.dart';
import 'package:location/location.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  _LocationPermissionScreenState createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  void _determinePosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    String longitude = _locationData.longitude.toString();
    String latitude = _locationData.latitude.toString();

    MySingleton.shared.location
        .putIfAbsent(double.parse(longitude), () => double.parse(latitude));
    print("longitude : ${longitude} latitude :  ${latitude}");
    print("data : ${MySingleton.shared.location.toString()}");
    if (MySingleton.shared.socialMediaProfilePci.isEmpty) {
      // Get.toNamed(MyRouter.emailEnterScreen);
      Get.offAndToNamed(MyRouter.emailEnterScreen);
    } else {
      Get.offAndToNamed(MyRouter.addProfilePicScreen);
      // Get.toNamed(MyRouter.addProfilePicScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: MyAppTheme.appBackgroundColor,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyAppTheme.gradientColorTop,
                MyAppTheme.gradientColorMid,
                MyAppTheme.gradientColorLast
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset(
                      Images.location,
                      height: screenSize.height * 0.15,
                      width: screenSize.height * 0.15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: LightTextBody(data: 'locationPermission'.tr),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _determinePosition(),
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 35),
                  alignment: Alignment.bottomCenter,
                  child: DarkButton(buttonText: 'confirmLocation'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
