import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:casino/controller/auth_controller.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureText1 = true;
  String password = "";
  String rePassword = "";
  String verifyCode = "";

  final AuthController _authController = Get.find();

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (password != rePassword) {
      Utility.showError("passwordNotMatch".tr);

      return;
    }

    _authController.resetPassword(
        MySingleton.shared.email, verifyCode, password);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyAppTheme.appBackgroundColor,
        appBar: AppBar(
          backgroundColor:  MyAppTheme.gradientColorTop,
          elevation: 0.0,
          leading: IconButton(
            padding: EdgeInsets.only(top: 25.0),
            icon: Icon(Icons.arrow_back, color: Colors.white,size: 40.0,),
            onPressed: () => Get.toNamed(MyRouter.forgetPasswordScreen)
          ),),

        body: SingleChildScrollView(
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

                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: LightTextHead(data: 'resetPassword'.tr),
                ),
                Container(
                  height: screenSize.height * 0.4,
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 40),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        TextFormField(
                          // maxLength: 20,
                          autofocus: false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            errorStyle:
                                const TextStyle(color: MyAppTheme.textWhite),
                            fillColor: MyAppTheme.textWhite,
                            filled: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
                            hintText: 'enterPassword'.tr,
                            alignLabelWithHint: true,
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
                            if (value.length < 8) {
                              return 'passwordError8'.tr;
                            } else if (value.length > 20) {
                              return 'passwordError20'.tr;
                            }
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 25,
                          ),
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
                                  15.0, 5.0, 10.0, 5.0),
                              hintText: 'reEnter'.tr,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureText1 = !_obscureText1;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscureText1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'passwordEmpty'.tr;
                              }
                              if (value.length < 8) {
                                return 'passwordError8'.tr;
                              } else if (value.length > 20) {
                                return 'passwordError20'.tr;
                              }
                            },
                            onSaved: (value) {
                              rePassword = value!;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 25,
                          ),
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
                                  15.0, 5.0, 10.0, 5.0),
                              fillColor: MyAppTheme.textWhite,
                              hintText: 'otp'.tr,
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
                                return 'pleaseEnterOtp'.tr;
                              }
                            },
                            onSaved: (value) {
                              verifyCode = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Obx(
                    () => _authController.isLoading.value
                        ? const Loading(
                            loadingMessage: '',
                          )
                        : GestureDetector(
                            onTap: () => _submit(),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 35),
                              alignment: Alignment.bottomCenter,
                              child: DarkButton(buttonText: 'update'.tr),
                            ),
                          ),
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
