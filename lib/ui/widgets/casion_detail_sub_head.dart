import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'review/add_resta_hotel_dialog_box.dart';

class CasionDetailSubHead extends StatefulWidget {
  const CasionDetailSubHead({
    Key? key,
    required this.casinoDetail,
  }) : super(key: key);

  final CasinoDetails casinoDetail;

  @override
  State<CasionDetailSubHead> createState() => _CasionDetailSubHeadState();
}

class _CasionDetailSubHeadState extends State<CasionDetailSubHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: MyAppTheme.casionDetailTop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.0,
                textDirection: TextDirection.ltr,
                semanticLabel:
                    'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
              ),
            ),
          ),
          Column(
            children: [
              // ignore: unnecessary_const
              Text(
                "Reviews".tr,
                style: TextStyle(color: MyAppTheme.profileText, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  widget.casinoDetail.casinoName,
                  style: const TextStyle(
                      color: MyAppTheme.casionTop, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${'Rating'.tr}: ${widget.casinoDetail.rating} of 5",
                  style: const TextStyle(
                      color: MyAppTheme.profileRatingYellow, fontSize: 18),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Utility.isUserSubscription()
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddRestaHotelDialogBox(
                          casinoDetail: widget.casinoDetail,
                        );
                      })
                  : Utility.showError("pleaseSub".tr);
              ;
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.0,
                textDirection: TextDirection.ltr,
                semanticLabel:
                    'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
              ),
            ),
          ),
        ],
      ),
    );
  }
}
