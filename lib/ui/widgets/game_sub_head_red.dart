import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:casino/model/find_casino_by_id.dart';

class GameSubHeadRed extends StatelessWidget {
  const GameSubHeadRed({
    Key? key,
    required this.casinoDetail,
  }) : super(key: key);

  final CasinoDetails casinoDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: MyAppTheme.redBackGround,
      child: Text(
        "${casinoDetail.casinoName} was updated ${Utility.getDay(casinoDetail)} days ago",
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 12,
          color: MyAppTheme.textWhite,
        ),
      ),
    );
  }
}
