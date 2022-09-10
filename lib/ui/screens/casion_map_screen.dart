import 'dart:developer';

import 'package:casino/controller/general_controller.dart';
import 'package:casino/controller/map_controller.dart';
import 'package:casino/model/find_casino.dart';
import 'package:casino/model/google_nearby.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/casion_map_card.dart';
import 'package:casino/ui/widgets/casion_map_card_google_nearby.dart';
import 'package:casino/ui/widgets/light_text_sub_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/map_range_dialog_box.dart';
import 'package:casino/ui/widgets/my_banner.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/ui/widgets/user_rate_reward_top.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'dart:async';

class CasionMapScreen extends StatefulWidget {
  const CasionMapScreen({Key? key}) : super(key: key);

  @override
  _CasionMapScreenState createState() => _CasionMapScreenState();
}

class _CasionMapScreenState extends State<CasionMapScreen> {
  late String _darkMapStyle;
  bool isOpen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);
  final GeneralController _generalController = Get.find();
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  final Completer<GoogleMapController> _googleMapController = Completer();
  final MapController _mapController = Get.put(MapController());
  final SheetController _sheetController = SheetController();
  final TextEditingController _serachTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log("CasionMapScreen  _CasionMapScreenState initState() ");
    setCurrentLocation();
    _loadMapStyles();
    // setState(() {
    //   _setMapStyle();
    // });
    setLanguage();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    log("CasionMapScreen  _CasionMapScreenState didChangeDependencies() ");
    //setState(() {});
  }

  _loadMapStyles() {
    _darkMapStyle = Constant.googleMapDark;
    // _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
  }

  // _setMapStyle() async {
  //   final controller = await _googleMapController.future;
  //   controller.setMapStyle(_darkMapStyle);
  // }

  setCurrentLocation() {
    Utility.getCurrentLatLong().then((value) {
      var lat = double.parse((value.latitude).toStringAsFixed(4));
      var long = double.parse((value.longitude).toStringAsFixed(4));
      _mapController.currentLat.value = lat;
      _mapController.currentLong.value = long;
    });
  }

  setLanguage() {
    try {
      _generalController.changeLanguage(Utility.getUserLang());
    } catch (e) {
      print("error : ${e.toString()}");
      e.printError();
    }
  }

  void _clearText() {
    _mapController.serachCasinoResult.clear();
    _mapController.serachGoogleNearbyResult.clear();
    _serachTextController.clear();
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      _mapController.serachCasinoResult.clear();
      _mapController.serachGoogleNearbyResult.clear();
      return;
    }

    if (_mapController.casinoResult.isNotEmpty) {
      List<CasinoResult> localCasions = [];
      for (var casinoResult in _mapController.casinoResult) {
        var casionName = casinoResult.casinoName.toString().toLowerCase();

        if (casionName.contains(text)) {
          localCasions.add(casinoResult);
        }
      }
      _mapController.serachCasinoResult.value = localCasions;
    }

    if (_mapController.googleNearbyResult.isNotEmpty) {
      List<Results> localCasions = [];
      for (var casinoResult in _mapController.googleNearbyResult) {
        var casionName = casinoResult.name.toString().toLowerCase();

        if (casionName.contains(text)) {
          log(" CasionMapScreen found   casionName $casionName  ");
          localCasions.add(casinoResult);
        }
      }
      _mapController.serachGoogleNearbyResult.value = localCasions;
    }
  }

  _addRecentCasion(CasinoResult casinoResult) {
    Get.toNamed(MyRouter.casionDetailScreen, arguments: casinoResult.casinoId);
    Utility.addRecentCasion(casinoResult);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        body: SlidingSheet(
          controller: _sheetController,
          closeOnBackButtonPressed: true,
          closeOnBackdropTap: true,
          elevation: 8,
          cornerRadius: 0,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.5, 1.0],
            positioning: SnapPositioning.relativeToSheetHeight,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ProfileHead(
                  isBackArrow: false,
                ),
                Obx(
                  () => _mapController.isLoading.value
                      ? const Center(
                          child: Loading(
                            loadingMessage: '',
                          ),
                        )
                      : Column(
                          children: [
                            UserRateRewardTop(
                              screenSize: screenSize,
                            ),
                            Utility.getAdsImageURL().isNotEmpty
                                ? Column(
                                    children: [
                                      MyBanner(screenSize: screenSize),
                                      MyGoogleMap(
                                          hight: 0.4,
                                          screenSize: screenSize,
                                          mapController: _mapController,
                                          googleMapController:
                                              _googleMapController,
                                          darkMapStyle: _darkMapStyle),
                                    ],
                                  )
                                : MyGoogleMap(
                                    hight: 0.5,
                                    screenSize: screenSize,
                                    mapController: _mapController,
                                    googleMapController: _googleMapController,
                                    darkMapStyle: _darkMapStyle),
                          ],
                        ),
                )
              ],
            ),
          ),
          builder: (context, state) {
            return Container(
              color: MyAppTheme.mapGradientColorLast,
              height: screenSize.height * 0.5,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MyAppTheme.mapGradientColorTop,
                          MyAppTheme.mapGradientColorMid,
                          MyAppTheme.mapGradientColorLast
                        ],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: LightTextSubHead(data: "casinosNearMe".tr),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sheetController.collapse();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(Images.drop_down),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: screenSize.width * 0.8,
                              margin: const EdgeInsets.only(
                                  right: 0, left: 10, bottom: 20),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.search),
                                  title: TextField(
                                    controller: _serachTextController,
                                    decoration: InputDecoration(
                                        hintText: 'searchForSpots'.tr,
                                        border: InputBorder.none),
                                    onChanged: onSearchTextChanged,
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () => _clearText(),
                                    child: const Icon(
                                      Icons.close,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MapRangeDialogBox(
                                        googleMapController:
                                            _googleMapController);
                                  }),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                width: screenSize.width * 0.15,
                                child: Image.asset(Images.filter),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => _mapController.isLoading.value
                        ? const Loading(
                            loadingMessage: '',
                          )
                        // : (_mapController.serachCasinoResult.isEmpty &&
                        //         _mapController.casinoResult.isNotEmpty)
                        //     ? const Center(
                        //         child:
                        //             LightTextSubHead(data: " No Result Found"),
                        //       )
                        : _mapController.serachCasinoResult.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      _mapController.serachCasinoResult.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          GestureDetector(
                                    onTap: () {
                                      _addRecentCasion(_mapController
                                          .serachCasinoResult[index]);
                                    },
                                    child: CasionMapCard(
                                        screenSize: screenSize,
                                        casinoResult: _mapController
                                            .serachCasinoResult[index]),
                                  ),
                                ),
                              )
                            : _mapController.casinoResult.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          _mapController.casinoResult.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              GestureDetector(
                                        onTap: () {
                                          _addRecentCasion(_mapController
                                              .casinoResult[index]);
                                        },
                                        child: CasionMapCard(
                                          screenSize: screenSize,
                                          casinoResult: _mapController
                                              .casinoResult[index],
                                        ),
                                      ),
                                    ),
                                  )
                                : _mapController
                                        .serachGoogleNearbyResult.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                          itemCount: _mapController
                                              .serachGoogleNearbyResult.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              GestureDetector(
                                            child: CasionMapCardGooleNearby(
                                              screenSize: screenSize,
                                              result: _mapController
                                                      .serachGoogleNearbyResult[
                                                  index],
                                            ),
                                          ),
                                        ),
                                      )
                                    : _mapController
                                            .googleNearbyResult.isNotEmpty
                                        ? Expanded(
                                            child: ListView.builder(
                                              itemCount: _mapController
                                                  .googleNearbyResult.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      GestureDetector(
                                                child: CasionMapCardGooleNearby(
                                                  screenSize: screenSize,
                                                  result: _mapController
                                                          .googleNearbyResult[
                                                      index],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: LightTextSubHead(
                                                data: "noCasionFound".tr),
                                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyGoogleMap extends StatefulWidget {
  MyGoogleMap({
    Key? key,
    required this.screenSize,
    required this.mapController,
    required this.googleMapController,
    required this.darkMapStyle,
    required this.hight,
  }) : super(key: key);

  final Size screenSize;
  final MapController mapController;
  final Completer<GoogleMapController> googleMapController;
  final String darkMapStyle;
  final double hight;

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("CasionMapScreen  _MyGoogleMapState initState() ");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    log("CasionMapScreen  _MyGoogleMapState didChangeDependencies() ");
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 2),
        height: widget.screenSize.height * widget.hight,
        child: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.mapController.currentLat.value,
                widget.mapController.currentLong.value),
            zoom: 14,
          ),
          markers: (widget.mapController.casinoResult.isEmpty &&
                  widget.mapController.googleNearbyResult.isEmpty)
              ? {}
              : widget.mapController.markers,
          onMapCreated: (GoogleMapController controller) {
            if (!widget.googleMapController.isCompleted) {
              //first calling is false
              //call "completer()"
              widget.googleMapController.complete(controller);
            } else {
              log("CasionMapScreen  _googleMapController ");
            }

            //controller.setMapStyle(darkMapStyle);
            // StreamSubscription<Position> positionStream =
            //     Geolocator.getPositionStream(
            //   desiredAccuracy: LocationAccuracy.high,
            // ).listen((Position position) {
            //   log(" CasionMapScreen location change ${position.latitude} ${position.longitude}");
            //   controller.animateCamera(
            //     CameraUpdate.newCameraPosition(
            //       CameraPosition(
            //           target: LatLng(position.latitude, position.longitude),
            //           zoom: 15),
            //     ),
            //   );
            // });
          },
        ),
      ),
    );
  }
}
