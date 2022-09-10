import 'package:casino/controller/general_controller.dart';
import 'package:casino/ui/widgets/covid_info.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading.dart';

class HygineReportDetail extends StatefulWidget {
  const HygineReportDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<HygineReportDetail> createState() => _HygineReportDetailState();
}

class _HygineReportDetailState extends State<HygineReportDetail> {
  final GeneralController _generalController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalController.getStaticPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Obx(
        () => _generalController.isLoading.value
            ? const Loading(
                loadingMessage: '',
              )
            :
            // _generalController.staticPageData.isNotEmpty
            //     ? _generalController.staticPageData.first.hygienReport.isNotEmpty?
            _generalController.staticPageData.first.hygienReport.isNotEmpty
                ? ListView.builder(
                    itemCount: _generalController
                        .staticPageData.first.hygienReport.length,
                    itemBuilder: (BuildContext context, int index) => CovidInfo(
                      title: _generalController
                          .staticPageData.first.hygienReport[index].title,
                      subTitle: _generalController
                          .staticPageData.first.hygienReport[index].discription,
                    ),
                  )
                : const LightTextHead(data: "No Hygien Report"),
      ),
    );
  }
}
