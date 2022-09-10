import 'dart:convert';
import 'dart:io';
import 'package:casino/controller/auth_controller.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/styles/my_strings.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({Key? key}) : super(key: key);

  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureText1 = true;
  String password = "";
  String rePassword = "";

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

    // List<int> imageBytes = uploadimage.readAsBytesSync();
    // String baseimage = base64Encode(imageBytes);

    _authController.signup(
        MySingleton.shared.username,
        MySingleton.shared.email,
        "",
        password,
        MySingleton.shared.location.toString(),
        MySingleton.shared.language,
        MySingleton.shared.deviceToken,
        MySingleton.shared.socialMediaProfilePci.isNotEmpty
            ? (base64
                .encode(utf8.encode(MySingleton.shared.socialMediaProfilePci)))
            : MySingleton.shared.uploadImage);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: MyAppTheme.appBackgroundColor,
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
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: LightTextHead(data: 'createPassword'.tr),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      MySingleton.shared.socialMediaProfilePci.isNotEmpty
                          ?
                          // Container(
                          //     height: screenSize.height * 0.2,
                          //     width: screenSize.width * 0.4,
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(
                          //         fit: BoxFit.fill,
                          //         image: NetworkImage(
                          //           MySingleton.shared.socialMediaProfilePci,
                          //         ),
                          //       ),
                          //     ),
                          //   )

                          CircleAvatar(
                              backgroundColor: MyAppTheme.textWhite,
                              radius: 65,
                              child: CircleAvatar(
                                radius: 64.0,
                                backgroundImage: Image.network(
                                  MySingleton.shared.socialMediaProfilePci,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ).image,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: MyAppTheme.textWhite,
                              radius: 65,
                              child: CircleAvatar(
                                radius: 64.0,
                                backgroundImage: Image.file(
                                  File(MySingleton.shared.image),
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ).image,
                              ),
                            ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 10),
                          child: LightTextHead(
                              data: MySingleton.shared.username.toString())),
                      Container(
                        height: screenSize.height * 0.25,
                        margin:
                            const EdgeInsets.only(top: 25, left: 40, right: 40),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              TextFormField(
                                maxLength: 20,
                                autofocus: false,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(

                                  errorStyle: const TextStyle(
                                      color: MyAppTheme.textWhite),

                                  fillColor: MyAppTheme.textWhite,
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 10.0, 5.0),
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
                                  top: 15,
                                ),
                                child: TextFormField(
                                  maxLength: 20,
                                  autofocus: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                        color: MyAppTheme.textWhite),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor: MyAppTheme.organe,
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
                                  onTap: () => _submit(),
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
