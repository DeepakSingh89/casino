import 'dart:developer';

import 'package:casino/controller/auth_controller.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/apple_button.dart';
import 'package:casino/ui/widgets/facebook_button.dart';
import 'package:casino/ui/widgets/green_light_button.dart';
import 'package:casino/ui/widgets/green_lighter_button.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String userName = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find();
  Map? userData;

  _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

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

    _authController.login(userName, password, MySingleton.shared.deviceToken);
  }

  _facebook() async {
    await FacebookAuth.i
        .login(permissions: ["public_profile", "email"]).then((result) {
      print("#Login facebook result : ${result.status}  ${result.message}");
      if (result.status == LoginStatus.success) {
        FacebookAuth.i
            .getUserData(fields: "email, name , picture")
            .then((requestData) {
          MySingleton.shared.email = requestData['email'];
          MySingleton.shared.username = requestData['name'];
          print("facebbok picture :  ${requestData['picture']}");
          print("facebbok picture :  ${requestData["picture"]["data"]["url"]}");
          MySingleton.shared.socialMediaProfilePci =
              requestData['picture'] == null
                  ? ""
                  : requestData["picture"]["data"]["url"];

          Get.toNamed(MyRouter.languageSelectScreen);
        });
      } else {
        Utility.showError(result.message.toString());
      }
    });
  }

  void _signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    log(" apple login email ${appleIdCredential.email}  familyName ${appleIdCredential.familyName} ");
    MySingleton.shared.email = appleIdCredential.email!;
    MySingleton.shared.username = appleIdCredential.familyName!;
    Get.toNamed(MyRouter.languageSelectScreen);
    // await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyAppTheme.gradientColorTop,
                  MyAppTheme.gradientColorMid,
                  MyAppTheme.gradientColorLast
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: Image.asset(
                    Images.logo,
                    height: screenSize.height * 0.15,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'login'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: MyAppTheme.textWhite,
                        fontFamily: Fonts.biotifSemiBold),
                  ),
                ),
                Container(
                  height: screenSize.height * 0.2,
                  margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        TextFormField(
                          // maxLength: 20,
                          cursorColor: MyAppTheme.gradientColorTop,
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 10.0, 20.0),
                            fillColor: MyAppTheme.textWhite,
                            errorStyle:
                                const TextStyle(color: MyAppTheme.textWhite),
                            hintText: 'username'.tr,
                            labelStyle: const TextStyle(
                                color: MyAppTheme.gradientColorLast),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: MyAppTheme.gradientColorMid),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                  color: MyAppTheme.gradientColorMid),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'userNameIsEmpty'.tr;
                            }

                            if (value.contains(' ')) {
                              return 'userNameSpace'.tr;
                            }

                            if (value.length < 3) {
                              return 'shouldBeMoreThen3'.tr;
                            }

                            if (value.length > 10) {
                              return 'shouldBeless30'.tr;
                            }
                          },
                          onSaved: (value) {
                            userName = value!;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            // maxLength: 20,
                            autofocus: false,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(color: MyAppTheme.textWhite),
                              fillColor: MyAppTheme.textWhite,
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 10.0, 20.0),
                              hintText: 'enterPassword'.tr,
                              labelStyle: const TextStyle(
                                  color: MyAppTheme.gradientColorLast),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'passwordEmpty'.tr;
                              }
                            },
                            onSaved: (value) {
                              password = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(MyRouter.forgetPasswordScreen),
                  child: Container(
                    padding: const EdgeInsets.only(right: 42, top: 5),
                    alignment: Alignment.centerRight,
                    child: LightTextBody(data: 'forgotPassword'.tr),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 35),
                  alignment: Alignment.bottomCenter,
                  child: Obx(
                    () => _authController.isLoading.value
                        ? const Loading(
                            loadingMessage: '',
                          )
                        : GestureDetector(
                            onTap: () => _login(),
                            child: Container(
                              height: 52,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: MyAppTheme.darkButtonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  'login'.tr,
                                  style: const TextStyle(
                                      color: MyAppTheme.textWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Fonts.biotifNormal),
                                ),
                              ),
                            )

                            //GreenLightButton(buttonText: 'login'.tr),
                            ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(MyRouter.languageSelectScreen),
                  child: Container(
                    margin: const EdgeInsets.only(left: 35, right: 35, top: 20),
                    alignment: Alignment.bottomCenter,
                    child: GreenLighterButton(buttonText: 'signUp'.tr),
                  ),
                ),
                GetPlatform.isIOS
                    ? GestureDetector(
                        onTap: () => _signInWithApple(),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 40),
                          alignment: Alignment.bottomCenter,
                          child: AppleButton(buttonText: 'appleLogin'.tr),
                        ),
                      )
                    : Text(""),
                GestureDetector(
                  onTap: () => _facebook(),
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 30, right: 30, top: 15, bottom: 200),
                    alignment: Alignment.bottomCenter,
                    child: FacebookButton(buttonText: 'facebookLogin'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
