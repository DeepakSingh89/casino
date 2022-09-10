import 'package:casino/controller/general_controller.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../ui/styles/my_app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import '../styles/images.dart';
import 'package:get/get.dart';
import '../routers/my_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationToWelcomeScreen);
  }

  void navigationToWelcomeScreen() {
    try {
      var _isLogin = Utility.isLoginRequired();
      //var _isLogin = false;
      print("SplashScreen  _isLogin : ${_isLogin}");
      if (_isLogin != null) {
        if (_isLogin) {
          Get.toNamed(MyRouter.myBottomNavScreen);
        } else {
          Get.toNamed(MyRouter.startupScreen);
        }
      } else {
        Get.toNamed(MyRouter.startupScreen);
      }
    } on Exception catch (e) {
      e.printError();
      Get.toNamed(MyRouter.startupScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: MyAppTheme.appBarColor),
    );

    Utility.loadSaveDataToCache();
    var android =
        const AndroidInitializationSettings('mipmap/app_notification');
    var ios = const IOSInitializationSettings();
    firebaseCloudMessaging_Listeners();
    _startTime();
  }

  void firebaseCloudMessaging_Listeners() async {
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    _firebaseMessaging.getToken().then((token) {
      print("token : ${token}");
      MySingleton.shared.deviceToken = token!;
    });
  }

  // void iOS_Permission() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  // }

  // showNotification(Map<String, dynamic> message) async {
  //   final data = jsonDecode(message['data']['data']);
  //   var android = new AndroidNotificationDetails(
  //     'sdffds dsffds',
  //     "CHANNLE NAME",
  //     "channelDescription",
  //   );
  //   var iOS = new IOSNotificationDetails();
  //   var platform = new NotificationDetails(android, iOS);
  //   await flutterLocalNotificationsPlugin.show( 0, data['title'], data['message'], platform);
  //   SharedPreferences.getInstance().then(
  //     (prefs) {
  //       int count;
  //       count = prefs.getInt(SharedpreferencesConstant.notificationCount);
  //       print('beofrecount : ${count}');
  //       if (count == null)
  //         prefs.setInt(SharedpreferencesConstant.notificationCount, 1);
  //       else
  //         prefs.setInt(SharedpreferencesConstant.notificationCount, count + 1);

  //       count = prefs.getInt(SharedpreferencesConstant.notificationCount);
  //       print('after count : ${count}  ');
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: MyAppTheme.appBackgroundColor,

        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.splace_background), fit: BoxFit.cover),
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
                child: Image.asset(
                  Images.casion_reports,
                  height: screenSize.height * 0.6,
                  width: screenSize.width * 0.8,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
