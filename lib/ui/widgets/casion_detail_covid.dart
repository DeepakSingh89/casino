import 'package:casino/controller/general_controller.dart';
import 'package:casino/model/find_casino_by_id.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/casion_button_green.dart';
import 'package:get/get.dart';

import 'review/add_casion_review_dialog_box.dart';

class CasionDetailCovid extends StatefulWidget {
  const CasionDetailCovid({
    Key? key,
    required this.casinoDetail,
  }) : super(key: key);

  final CasinoDetails casinoDetail;

  @override
  State<CasionDetailCovid> createState() => _CasionDetailCovidState();
}

class _CasionDetailCovidState extends State<CasionDetailCovid> {
  final GeneralController _generalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.all(8),
        color: MyAppTheme.greenCasionTab,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
                //onTap: () => showAsBottomSheet(),
                onTap: () => {
                      if (_generalController.showCovid.value)
                        {_generalController.showCovid.value = false}
                      else
                        {_generalController.showCovid.value = true}
                    },
                child: Image.asset(Images.covid)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'covid'.tr,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  color: MyAppTheme.textWhite,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(MyRouter.gameSelectCasion,
                  arguments: widget.casinoDetail),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CasionButtonGreen(
                  buttonText: 'TableDetails'.tr,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Utility.isUserSubscription()
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddCasionReviewDialogBox(
                            casinoDetail: widget.casinoDetail,
                          );
                        })
                    : Utility.showError("pleaseSub".tr);
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CasionButtonGreen(
                  buttonText: 'AddReview'.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
