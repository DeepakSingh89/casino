import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: MyAppTheme.greenTabSelected,
      unselectedLabelColor: Colors.white,
      indicatorPadding: const EdgeInsets.only(right: 15, left: 15),
      indicatorColor: MyAppTheme.greenTabSelected,
      indicatorWeight: 5,
      labelStyle: const TextStyle(
        //   fontFamily: Fonts.biotifNormal,
        fontSize: 13,
      ),
      tabs: [
        Tab(text: 'casino'.tr),
        Tab(text: 'food'.tr),
        Tab(text: 'hotel'.tr),
        Tab(text: 'forum'.tr),
      ],
      controller: _tabController,
    );
  }
}
