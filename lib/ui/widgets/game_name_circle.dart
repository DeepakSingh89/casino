import 'package:casino/model/game_min_max.dart';
import 'package:casino/ui/widgets/game_max_min.dart';
import 'package:casino/ui/widgets/game_max_min_card.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:flutter/material.dart';

class GameNameCircle extends StatefulWidget {
  const GameNameCircle(
      {Key? key,
      required this.orginalGame,
      required this.screenSize,
      required this.image,
      required this.maxMinDatas,
      required this.gameName})
      : super(key: key);

  final Size screenSize;
  final String image;
  final List<Data> maxMinDatas;
  final String gameName, orginalGame;

  @override
  State<GameNameCircle> createState() => _GameNameCircleState();
}

class _GameNameCircleState extends State<GameNameCircle> {
  String maxData = "0";
  String minData = "0";

  @override
  void initState() {
    super.initState();
    setMinMax();
  }

  setMinMax() {
    for (var element in widget.maxMinDatas) {
      print(
          " gameName ${element.gameName}  orginalGame ${widget.orginalGame} ");
      if (element.gameName == widget.orginalGame) {
        setState(() {
          maxData = element.maxBetSize.toString();
          minData = element.minBetSize.toString();
        });

        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          LightTextSubHead(data: widget.gameName),
          SizedBox(
            height: widget.screenSize.height * 0.02,
          ),
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 60.0,
              child: ClipRRect(
                child: Image.asset(widget.image),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          GameMaxMin(
            screenSize: widget.screenSize,
            max: maxData,
            min: minData,
          ),
        ],
      ),
    );
  }
}
