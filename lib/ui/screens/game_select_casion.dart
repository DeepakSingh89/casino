import 'package:casino/controller/casion_controller.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/game_name_circle.dart';
import 'package:casino/ui/widgets/game_sub_head_red.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/ui/widgets/user_rate_reward_top.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:casino/model/find_casino_by_id.dart';

class GameSelectCasion extends StatefulWidget {
  const GameSelectCasion({Key? key}) : super(key: key);

  @override
  _GameSelectCasionState createState() => _GameSelectCasionState();
}

class _GameSelectCasionState extends State<GameSelectCasion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CasinoDetails casinoDetail;
  final CasionController _casionController = Get.find();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    casinoDetail = Get.arguments as CasinoDetails;
    _casionController.getMinmaxCasinoId(casinoDetail.casinoId);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  openGameCardScreen(String gameName) {
    var gameFound = false;
    List<GameMode> gameMode = [];

    for (var element in casinoDetail.gameMode) {
      if (element.gameName == gameName) {
        print(" _GameSelectCasionState minBetSize  ${element.minBetSize} " +
            "maxBetSize : ${element.maxBetSize}");
        print("gameName ${element.gameName}  id ${element.id} ");
        gameFound = true;
        gameMode.add(
          GameMode(
            id: element.id,
            gameName: element.gameName,
            subGameName: element.gameName,
            gameActive: element.gameActive,
            minBetSize: element.minBetSize,
            maxBetSize: element.maxBetSize,
            createdDate: element.createdDate,
            modifidDate: element.modifidDate,
            modifidBy: element.modifidBy,
            modifidById: element.modifidById,
          ),
        );
      }
    }

    if (gameFound) {
      Get.toNamed(MyRouter.gameCardScreen, arguments: [casinoDetail, gameMode]);
    } else {
      Utility.showError("noGameavailable".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
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
            children: [
              ProfileHead(
                isBackArrow: true,
              ),
              UserRateRewardTop(
                screenSize: screenSize,
              ),
              GameSubHeadRed(casinoDetail: casinoDetail),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Obx(
                () => _casionController.isCasionMinMax.value
                    ? const Loading(
                        loadingMessage: '',
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          openGameCardScreen("Blackjack"),
                                      child: GameNameCircle(
                                        screenSize: screenSize,
                                        image: Images.poker,
                                        gameName: "Blackjack".tr,
                                        maxMinDatas:
                                            _casionController.maxMinDatas,
                                        orginalGame: Constant.Blackjack,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => openGameCardScreen("Craps"),
                                      child: GameNameCircle(
                                        screenSize: screenSize,
                                        image: Images.roulette,
                                        gameName: "Craps".tr,
                                        maxMinDatas:
                                            _casionController.maxMinDatas,
                                        orginalGame: Constant.Craps,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.05,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          openGameCardScreen("Roulette"),
                                      child: GameNameCircle(
                                        gameName: "Roulette".tr,
                                        screenSize: screenSize,
                                        image: Images.blackjack,
                                        maxMinDatas:
                                            _casionController.maxMinDatas,
                                        orginalGame: Constant.Roulette,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => openGameCardScreen("Poker"),
                                      child: GameNameCircle(
                                        gameName: "Poker".tr,
                                        screenSize: screenSize,
                                        image: Images.blackjack,
                                        maxMinDatas:
                                            _casionController.maxMinDatas,
                                        orginalGame: Constant.Poker,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.05,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          openGameCardScreen("Baccarat"),
                                      child: GameNameCircle(
                                        gameName: "Baccarat".tr,
                                        screenSize: screenSize,
                                        image: Images.blackjack,
                                        maxMinDatas:
                                            _casionController.maxMinDatas,
                                        orginalGame: Constant.Baccarat,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
