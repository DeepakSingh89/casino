import 'package:casino/ui/styles/fonts.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/add_post_button_green.dart';
import 'package:casino/ui/widgets/light_text_body.dart';
import 'package:casino/utiles/constant.dart';
import 'package:flutter/material.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:get/get.dart';

class GameCardGoBack extends StatefulWidget {
  const GameCardGoBack({
    Key? key,
    required this.casinoDetail,
    required this.games,
  }) : super(key: key);

  final CasinoDetails casinoDetail;
  final String games;

  @override
  State<GameCardGoBack> createState() => _GameCardGoBackState();
}

class _GameCardGoBackState extends State<GameCardGoBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 35.0,
              child: ClipRRect(
                child: FadeInImage.assetNetwork(
                  placeholder: Images.game,
                  image:
                      "${Constant.imageURL}${widget.casinoDetail.picVersion}/${widget.casinoDetail.picId}",
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: LightTextBody(
                    data: widget.casinoDetail.casinoName,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                FittedBox(
                  child: Text(
                    widget.casinoDetail.address,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: MyAppTheme.ratingCol,
                        fontFamily: Fonts.biotifNormal),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 18),
                  child: Text(
                    "${widget.games} Tables",
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: MyAppTheme.gradientColorTop,
                        fontFamily: Fonts.biotifNormal),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: AddPostButtonGreen(buttonText: "Go Back"),
            ),
          )
        ],
      ),
    );
  }
}
