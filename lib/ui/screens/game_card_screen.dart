import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/game_card_go_back.dart';
import 'package:casino/ui/widgets/game_max_min_card.dart';
import 'package:casino/ui/widgets/game_sub_head_red.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/ui/widgets/user_rate_reward_top.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:casino/model/find_casino_by_id.dart';

class GameCardScreen extends StatefulWidget {
  const GameCardScreen({Key? key}) : super(key: key);

  @override
  _GameCardScreenState createState() => _GameCardScreenState();
}

class _GameCardScreenState extends State<GameCardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<GameMode> gameMode = [];
  late CasinoDetails casinoDetail;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    var getArg = Get.arguments;
    casinoDetail = getArg[0];
    gameMode = getArg[1];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.backgroundBlack,
        body: Column(
          children: [
            ProfileHead(
              isBackArrow: false,
            ),
            UserRateRewardTop(
              screenSize: screenSize,
            ),
            GameSubHeadRed(casinoDetail: casinoDetail),
            GameCardGoBack(
              casinoDetail: casinoDetail,
              games: "${gameMode.length} ${gameMode.first.gameName}",
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: screenSize.height * 0.5,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: gameMode.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (Utility.isUserSubscription()) {
                          Get.toNamed(MyRouter.gameMaxMinSet, arguments: [
                            casinoDetail.casinoId,
                            gameMode[index].id,
                            gameMode[index].maxBetSize.toString(),
                            gameMode[index].minBetSize.toString(),
                          ]);
                        } else {
                          Utility.showError("pleaseDoSubscription".tr);
                        }
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            Images.game_card,
                            alignment: Alignment.center,
                            fit: BoxFit.fitWidth,
                          ),
                          GameMaxMinCard(
                            screenSize: screenSize,
                            max: gameMode[index].maxBetSize.toString(),
                            min: gameMode[index].minBetSize.toString(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
