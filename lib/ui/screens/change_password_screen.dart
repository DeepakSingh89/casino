import 'package:casino/controller/auth_controller.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  String password = "";
  String oldPassword = "";
  String verifyCode = "";
  String confirmPassword = "";

  final AuthController _authController = Get.find();

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (password != confirmPassword) {
      Utility.showError("passwordNotMatch".tr);
      return;
    }

    _authController.changePassword(Utility.getUserID(), password, oldPassword);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyAppTheme.backgroundBlack,
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ProfileHead(
                  isBackArrow: false,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 15),
                        child: LightTextHead(data: "changePassword".tr),
                      ),
                      const SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: screenSize.height * 0.35,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      color: MyAppTheme.textWhite),
                                  fillColor: MyAppTheme.textWhite,
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 10.0, 5.0),
                                  hintText: 'oldPassword'.tr,
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
                                  oldPassword = value!;
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 15,
                                ),
                                child: TextFormField(
                                  autofocus: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                        color: MyAppTheme.textWhite),
                                    fillColor: MyAppTheme.textWhite,
                                    filled: true,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        15.0, 5.0, 10.0, 5.0),
                                    hintText: 'newPassword'.tr,
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
                                    password = value!;
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 15,
                                ),
                                child: TextFormField(
                                  autofocus: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                        color: MyAppTheme.textWhite),
                                    fillColor: MyAppTheme.textWhite,
                                    filled: true,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        15.0, 5.0, 10.0, 5.0),
                                    hintText: 'confirmNewPassword'.tr,
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _obscureText2
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _obscureText2 = !_obscureText2;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: _obscureText2,
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
                                    confirmPassword = value!;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.06,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
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
                                          child: DarkButton(
                                              buttonText: 'update'.tr),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
