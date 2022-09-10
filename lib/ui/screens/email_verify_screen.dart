import 'package:casino/controller/auth_controller.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/styles/my_strings.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  _EmailVerifyScreenState createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  String verifyCode = "";
  final _formKey = GlobalKey<FormState>();
  AuthController _authController = Get.find();
  String email = "";
  void _validateCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _authController.verifyOtp(MySingleton.shared.email, verifyCode);
  }

  void _resendOtp() async {
    _formKey.currentState!.save();

    _authController.reSendOTP(MySingleton.shared.email);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: MyAppTheme.appBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
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
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: LightTextHead(data: 'enterConfirmCode'.tr),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        child:
                            LightTextSubHead(data: 'enterVerificationCode'.tr),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 25, left: 50, right: 50),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            cursorColor: MyAppTheme.gradientColorTop,
                            autofocus: false,
                            // keyboardType: TextInputType.emailAddress,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(color: MyAppTheme.textWhite),
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 25.0, 50, 25.0),
                              fillColor: MyAppTheme.textWhite,
                              hintText: 'verificationCode'.tr,
                              // labelText: "         ${MyStrings.verificationCode}",
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
                                return 'pleaseEnterCode'.tr;
                              }
                            },
                            onSaved: (value) {
                              verifyCode = value!;
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _resendOtp(),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Image.asset(
                                Images.resend,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LightTextBody(data: 'resendCode'.tr),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Obx(
                //     () => _authController.isLoading.value
                //         ? Loading(
                //             loadingMessage: '',
                //           )
                //         : GestureDetector(
                //             onTap: () => _validateCode(),
                //             child: Container(
                //               margin: const EdgeInsets.only(
                //                   left: 35, right: 35, bottom: 35),
                //               alignment: Alignment.bottomCenter,
                //               child: DarkButton(buttonText: MyStrings.next),
                //             ),
                //           ),
                //   ),
                // ),

                Expanded(
                  flex: 1,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(width: screenSize.width * 0.4),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.textSecondary,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.gradientColorTop,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.textSecondary,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.textSecondary,
                              radius: 6.0,
                              child: ClipRRect(
                                child: Text(""),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Obx(
                          () => _authController.isLoading.value
                              ? const Loading(
                                  loadingMessage: '',
                                )
                              : GestureDetector(
                                  onTap: () => _validateCode(),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 35, right: 35, bottom: 35),
                                    alignment: Alignment.bottomCenter,
                                    child: DarkButton(buttonText: 'next'.tr),
                                  ),
                                ),
                        ),
                      ),
                    ],
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
