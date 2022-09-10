import 'dart:developer';

import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/game_max_min_card.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameMAxMinSetComplete extends StatefulWidget {
  const GameMAxMinSetComplete({Key? key}) : super(key: key);

  @override
  _GameMAxMinSetCompleteState createState() => _GameMAxMinSetCompleteState();
}

class _GameMAxMinSetCompleteState extends State<GameMAxMinSetComplete>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  var minFormValue = null;
  var maxFormValue = null;
  late var casinoId;
  late var gameModeId;
  late var maxBetSize;
  late var minBetSize;
  final GeneralController _generalController = Get.find();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    var getArg = Get.arguments;
    casinoId = getArg[0];
    gameModeId = getArg[1];
    maxBetSize = getArg[2];
    minBetSize = getArg[3];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    maxFormValue ??= maxBetSize;

    minFormValue ??= minBetSize;

    if (maxFormValue == 0.0 || maxFormValue == 0) {
      Utility.showError("pleaseMoreThen0".tr);
      return;
    }

    if (minFormValue == 0.0 || minFormValue == 0) {
      Utility.showError("pleaseMoreThen0".tr);
      return;
    }

    if (double.parse(maxFormValue) < double.parse(minFormValue)) {
      Utility.showError("maxMinError".tr);
      return;
    }

    _generalController.gameUpdateByUser(casinoId, gameModeId, (maxFormValue),
        (minFormValue), Utility.getUserID());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyAppTheme.mapGradientColorLast,
                //  MyAppTheme.mapGradientColorMid,
                MyAppTheme.mapGradientColorTop
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                  alignment: Alignment.topLeft,
                  child: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 40),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Container(
                height: screenSize.height * 0.32,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 240),
                        child: LightTextBody(
                          data: "Min :",
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      TextFormField(
                        //initialValue: minBetSize,
                        maxLength: 5,
                        cursorColor: MyAppTheme.gradientColorTop,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorStyle:
                              const TextStyle(color: MyAppTheme.textWhite),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 20.0),
                          fillColor: MyAppTheme.textWhite,
                          hintText: "\$$minBetSize",
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
                            borderSide:
                                BorderSide(color: MyAppTheme.gradientColorMid),
                          ),
                        ),
                        validator: (value) {},
                        onSaved: (value) {
                          if (value!.isEmpty || value == null) {
                            minFormValue = minBetSize;
                          } else {
                            minFormValue = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),

                      // MAX
                      const Padding(
                        padding: EdgeInsets.only(right: 240),
                        child: LightTextBody(
                          data: "Max :",
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      TextFormField(
                        maxLength: 5,
                        // initialValue: maxBetSize,
                        cursorColor: MyAppTheme.gradientColorTop,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorStyle:
                              const TextStyle(color: MyAppTheme.textWhite),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 20.0),
                          fillColor: MyAppTheme.textWhite,
                          hintText: "\$$maxBetSize",
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
                            borderSide:
                                BorderSide(color: MyAppTheme.gradientColorMid),
                          ),
                        ),
                        validator: (value) {},
                        onSaved: (value) {
                          if (value!.isEmpty || value == null) {
                            maxFormValue = maxBetSize;
                          } else {
                            maxFormValue = value;
                          }
                        },
                        // onFieldSubmitted: (value) {
                        //   maxFormValue = value.toString();
                        // },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Image.asset(
                Images.game_card,
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: screenSize.width * 0.26,
              //     ),
              //     SizedBox(
              //       width: screenSize.width * 0.6,
              //       child: GameMaxMinCard(
              //           screenSize: screenSize,
              //           max: maxBetSize,
              //           min: minBetSize),
              //     ),
              //   ],
              // ),

              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.22,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.6,
                    child: GameMaxMinCard(
                        screenSize: screenSize,
                        max: maxBetSize,
                        min: minBetSize),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Obx(
                () => _generalController.isLoadingGame.value
                    ? const Loading(
                        loadingMessage: '',
                      )
                    : GestureDetector(
                        onTap: () => _submit(),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 40),
                          //  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                          height: 50,
                          decoration: BoxDecoration(
                            color: MyAppTheme.gradientColorTop,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'DONE'.tr,
                              style: const TextStyle(
                                  color: MyAppTheme.textWhite,
                                  fontSize: 14,
                                  fontFamily: Fonts.biotifNormal),
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
