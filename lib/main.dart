import 'package:casino/controller/binding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'ui/routers/my_router.dart';
import 'ui/styles/locale_string.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  BindingController().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "";
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MainApp());
  });
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    services.SystemChrome.setPreferredOrientations([
      services.DeviceOrientation.portraitUp,
      services.DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      //locale: DevicePreview.of(context).locale,
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Casino',
      getPages: MyRouter.route,
    );
  }
}
