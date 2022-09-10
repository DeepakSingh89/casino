import 'package:casino/controller/casion_controller.dart';
import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/casion_detail_covid.dart';
import 'package:casino/ui/widgets/casion_detail_image.dart';
import 'package:casino/ui/widgets/casion_detail_sub_head.dart';
import 'package:casino/ui/widgets/casion_tab_view.dart';
import 'package:casino/ui/widgets/hygine_report_detail.dart';
import 'package:casino/ui/widgets/loading.dart';

import 'package:casino/ui/widgets/my_tab_bar.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CasionDetailScreen extends StatefulWidget {
  const CasionDetailScreen({Key? key}) : super(key: key);

  @override
  _CasionDetailScreenState createState() => _CasionDetailScreenState();
}

class _CasionDetailScreenState extends State<CasionDetailScreen>
    with SingleTickerProviderStateMixin {
  var casinoId = "";
  late TabController _tabController;
  final GeneralController _generalController = Get.find();
  final CasionController _casionController = Get.find();

  @override
  void initState() {
    casinoId = Get.arguments;
    _casionController.getCasinoDetails(casinoId);
    _casionController.getFavoriteCasinoDetails(Utility.getUserID());
    _casionController.isCasionFavt.value == false;
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.casionTabBackgroud,
        body: DefaultTabController(
          length: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileHead(
                isBackArrow: false,
              ),
              Obx(
                () => _casionController.isLoadingCasionDetails.value
                    ? const Loading(
                        loadingMessage: '',
                      )
                    : Column(
                        children: [
                          CasionDetailSubHead(
                              casinoDetail:
                                  _casionController.casinoDetails.first),
                          CasionDetailImage(
                            screenSize: screenSize,
                            casinoDetail: _casionController.casinoDetails.first,
                            casionController: _casionController,
                            favouriteLists: _casionController.favouriteList,
                          ),
                          CasionDetailCovid(
                              casinoDetail:
                                  _casionController.casinoDetails.first),
                        ],
                      ),
              ),
              Expanded(
                child: Obx(
                  () => _generalController.showCovid.value
                      ? Container(
                          color: MyAppTheme.greenCasionTab,
                          child: const HygineReportDetail())
                      :
                      // _casionController.casinoDetails.isEmpty
                      //     ? Text("")
                      //     :

                      _casionController.isLoadingCasionDetails.value
                          ? const Loading(
                              loadingMessage: '',
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                MyTabBar(tabController: _tabController),
                                CasionTabView(
                                    screenSize: screenSize,
                                    tabController: _tabController,
                                    casionId: casinoId,
                                    casinoDetail:
                                        _casionController.casinoDetails.first),
                              ],
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
