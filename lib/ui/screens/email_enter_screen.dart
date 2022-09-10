import 'package:casino/controller/auth_controller.dart';
import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailEnterScreen extends StatefulWidget {
  const EmailEnterScreen({Key? key}) : super(key: key);

  @override
  _EmailEnterScreenState createState() => _EmailEnterScreenState();
}

class _EmailEnterScreenState extends State<EmailEnterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find();

  String email = "";
  int _radioSelected = 0;

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (_radioSelected == 0) {
      Utility.showError("pleaseAccept".tr);
      return;
    }

    print("EmailEnterScreen  location :  ${MySingleton.shared.location}");
    print("EmailEnterScreen language :  ${MySingleton.shared.language}");

    MySingleton.shared.email = email.toString();
    print(" email : ${MySingleton.shared.email}");
    _authController.sendOTP(email);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: LightTextHead(data: 'createAccount'.tr),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      LightTextSubHead(data: 'enterEmailAddress'.tr),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 25, left: 50, right: 50),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            cursorColor: MyAppTheme.gradientColorTop,
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(color: MyAppTheme.textWhite),
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  10.0, 25.0, 0.2, 25.0),
                              fillColor: MyAppTheme.textWhite,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0,
                                    left: 25,
                                    right: 10), // add padding to adjust icon
                                child: Icon(
                                  Icons.email,
                                  color: MyAppTheme.gradientColorTop,
                                ),
                              ), //labelText: 'Enter Email Address',
                              hintText: "emailAddress".tr,
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
                              if (value!.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.com')) {
                                return 'invalidEmail'.tr;
                              }
                            },
                            onSaved: (value) {
                              print("onSaved() called");
                              // _authData['email'] = value!.toString();
                              email = value!.toString();
                            },
                            onFieldSubmitted: (value) {
                              print("onSaved() called");
                              //_authData['email'] = value!.toString();
                              email = value.toString();
                            },
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 5, left: 35, right: 10),
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: _radioSelected,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      _radioSelected = 1;
                                    });
                                  }),
                              Text(
                                "iaccept".tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(
                                    MyRouter.generalScreenTermCondition),
                                child: Text(
                                  "TermsAndCondition".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Text(
                                "and".tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(
                                    MyRouter.generalScreenPrivacyPolicy),
                                child: Text(
                                  "privacyPolicy".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                  ),
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
