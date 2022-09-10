import 'dart:convert';
import 'dart:developer';
import 'package:casino/model/find_casino.dart';
import 'package:casino/model/google_nearby.dart';
import 'package:casino/ui/routers/my_router.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../api_base_helper/api_base_helper.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();
  var isLoading = false.obs;
  var casinoResult = List<CasinoResult>.empty().obs;
  var serachCasinoResult = List<CasinoResult>.empty().obs;
  // var googleNearby_ = GoogleNearby(
  //     name: "",
  //     photos: [],
  //     geometry: Geometry(
  //       location: Location(lat: 0.0, lng: 0.0),
  //     )).obs;

  var googleNearbyResult = List<Results>.empty().obs;
  var serachGoogleNearbyResult = List<Results>.empty().obs;
  var currentLat = 0.0.obs;
  var currentLong = 0.0.obs;
  var markers = <Marker>{}.obs;
  var initRange = Utility.convertIntoMile(Utility.getRadius()).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    print('onInit called');
    currentLogLat(initRange.value);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('AfteronReady called');
  }

  @override
  void onClose() {
    //mobileTextController?.dispose();
    super.onClose();
    print('onClose called');
  }

  void getMapData(double lat, double longi, double range) async {
    log('MapController getMapData called()');
    isLoading.value = true;

    dynamic body = {
      'lat': lat.toString(),
      'long': longi.toString(),
      'maxDistance': range.toString()
    };

    try {
      final response = await _helper.post("casino/find-casino", (body));
      log('MapController response $response');
      FindCasino findCasino = FindCasino.fromJson(response);
      if (findCasino.status == "success") {
        if (findCasino.casinoResult.isNotEmpty) {
          // casinoResult.value = [];
          casinoResult.value = findCasino.casinoResult;
          getmarkers(casinoResult, []);
        } else {
          casinoResult.value = [];
          markers.value = {};
          getGoogleCasionNearby(lat, longi, range);
        }
        isLoading.value = false;
      } else {
        if (findCasino.message == "Token_Expired ") {
          Utility.logout();
          return;
        }
        print('e :  {$findCasino.message}');
        Utility.showError(findCasino.message);
      }
    } catch (e, s) {
      print('e :  {$s}');
      log("error : ${s}");
      e.printError();
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoading.value = false;
    }
  }

  void getGoogleCasionNearby(double lat, double longi, double range) async {
    try {
      isLoading.value = true;
      // lat = 15.5012;
      // longi = 73.8290;
      //var data =
      //     "{\"html_attributions\":[],\"results\":[{\"business_status\":\"OPERATIONAL\",\"geometry\":{\"location\":{\"lat\":36.2868678,\"lng\":115.1541673},\"viewport\":{\"northeast\":{\"lat\":36.28821077989272,\"lng\":115.1555721298927},\"southwest\":{\"lat\":36.28551112010727,\"lng\":115.1528724701073}}},\"icon\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png\",\"icon_background_color\":\"#7B9EB0\",\"icon_mask_base_uri\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet\",\"name\":\"Daming Veteran Cadre Activities Centre\",\"place_id\":\"ChIJnSsAMEbs3DURGfX6m0vyR4c\",\"plus_code\":{\"compound_code\":\"75P3+PM Daming, Handan, Hebei, China\",\"global_code\":\"8P8Q75P3+PM\"},\"rating\":0,\"reference\":\"ChIJnSsAMEbs3DURGfX6m0vyR4c\",\"scope\":\"GOOGLE\",\"types\":[\"casino\",\"point_of_interest\",\"establishment\"],\"user_ratings_total\":0,\"vicinity\":\"Handan, Daming, 万大街\"},{\"business_status\":\"OPERATIONAL\",\"geometry\":{\"location\":{\"lat\":36.0721825,\"lng\":115.1995231},\"viewport\":{\"northeast\":{\"lat\":36.07354947989272,\"lng\":115.2008772798927},\"southwest\":{\"lat\":36.07084982010728,\"lng\":115.1981776201073}}},\"icon\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png\",\"icon_background_color\":\"#7B9EB0\",\"icon_mask_base_uri\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet\",\"name\":\"Shenhua Club\",\"place_id\":\"ChIJLfqyuUiX3DURyKeWkjThOA4\",\"plus_code\":{\"compound_code\":\"35CX+VR Nanle, Puyang, Henan, China\",\"global_code\":\"8P8Q35CX+VR\"},\"rating\":0,\"reference\":\"ChIJLfqyuUiX3DURyKeWkjThOA4\",\"scope\":\"GOOGLE\",\"types\":[\"casino\",\"point_of_interest\",\"establishment\"],\"user_ratings_total\":0,\"vicinity\":\"Puyang, Nanle, 昌州东路\"},{\"business_status\":\"OPERATIONAL\",\"geometry\":{\"location\":{\"lat\":36.2670981,\"lng\":115.1750592},\"viewport\":{\"northeast\":{\"lat\":36.26845202989271,\"lng\":115.1763710298927},\"southwest\":{\"lat\":36.26575237010727,\"lng\":115.1736713701073}}},\"icon\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png\",\"icon_background_color\":\"#7B9EB0\",\"icon_mask_base_uri\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet\",\"name\":\"Xinsheng Service Area\",\"place_id\":\"ChIJrbop5WLs3DURvX8f2ODKeHg\",\"plus_code\":{\"compound_code\":\"758G+R2 Daming, Handan, Hebei, China\",\"global_code\":\"8P8Q758G+R2\"},\"rating\":0,\"reference\":\"ChIJrbop5WLs3DURvX8f2ODKeHg\",\"scope\":\"GOOGLE\",\"types\":[\"casino\",\"point_of_interest\",\"establishment\"],\"user_ratings_total\":0,\"vicinity\":\"Handan, Daming, 五得利街\"},{\"business_status\":\"OPERATIONAL\",\"geometry\":{\"location\":{\"lat\":36.2874134,\"lng\":115.1375811},\"viewport\":{\"northeast\":{\"lat\":36.28872797989272,\"lng\":115.1389122798927},\"southwest\":{\"lat\":36.28602832010728,\"lng\":115.1362126201073}}},\"icon\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png\",\"icon_background_color\":\"#7B9EB0\",\"icon_mask_base_uri\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet\",\"name\":\"Xindongfang Business Clubhouse\",\"place_id\":\"ChIJT3vKl7Pt3DURu0eNrj_BxLQ\",\"plus_code\":{\"compound_code\":\"74PQ+X2 Daming, Handan, Hebei, China\",\"global_code\":\"8P8Q74PQ+X2\"},\"rating\":0,\"reference\":\"ChIJT3vKl7Pt3DURu0eNrj_BxLQ\",\"scope\":\"GOOGLE\",\"types\":[\"casino\",\"point_of_interest\",\"establishment\"],\"user_ratings_total\":0,\"vicinity\":\"Handan, Daming, 大名府路\"},{\"business_status\":\"OPERATIONAL\",\"geometry\":{\"location\":{\"lat\":36.2900834,\"lng\":115.1784132},\"viewport\":{\"northeast\":{\"lat\":36.29148057989273,\"lng\":115.1797701298927},\"southwest\":{\"lat\":36.28878092010728,\"lng\":115.1770704701073}}},\"icon\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png\",\"icon_background_color\":\"#7B9EB0\",\"icon_mask_base_uri\":\"https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet\",\"name\":\"Jingangwan Leisure Square\",\"place_id\":\"ChIJOzqQDA7s3DURTTrhgj1WnB8\",\"plus_code\":{\"compound_code\":\"75RH+29 Daming, Handan, Hebei, China\",\"global_code\":\"8P8Q75RH+29\"},\"rating\":0,\"reference\":\"ChIJOzqQDA7s3DURTTrhgj1WnB8\",\"scope\":\"GOOGLE\",\"types\":[\"casino\",\"point_of_interest\",\"establishment\"],\"user_ratings_total\":0,\"vicinity\":\"Handan, Daming, 天雄路\"}],\"status\":\"OK\"}";
      final response = await _helper.getGoogle(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$longi&radius=$range&type=Casino&keyword=Casino&key=${Constant.mapKey}");
      //log('MapController getGoogleCasionNearby $response');
      GoogleNearby googleNearby = GoogleNearby.fromJson(response);
      if (googleNearby.status == "OK") {
        // googleNearbyResult.value = [];
        googleNearbyResult.value = googleNearby.results;
        getmarkers([], googleNearby.results);
      } else {
        googleNearbyResult.value = [];
        markers.value = {};
        Utility.showError("noCasionFound".tr);
      }
      isLoading.value = false;
    } catch (e, s) {
      print('error :  {$s}');
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoading.value = false;
    }
  }

  Set<Marker> getmarkers(
      List<CasinoResult> casinoResult, List<Results> results) {
    var i = 0;
    log(" getmarkers() called");
    if (casinoResult.isEmpty && results.isEmpty) {
      log(" MapController Both list is empty returning");
      update();
      markers.value = {};

      return markers;
    }

    if (casinoResult.isNotEmpty) {
      for (var element in casinoResult) {
        i++;
        var markerId = MarkerId(i.toString());
        log("MapController element ${element.casinoName}");
        markers.add(
          Marker(
            markerId: markerId,
            //position: LatLng(element.location[0], element.location[1]),
            position: LatLng(element.location[1], element.location[0]),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
                title: element.casinoName,
                onTap: () {
                  addRecentCasion(element);
                },
                snippet: "Snipet ${element.casinoName}"),
          ),
        );
      }
    }

    if (results.isNotEmpty) {
      for (var element in results) {
        i++;
        var markerId = MarkerId(i.toString());
        log("MapController element ${element.name}");
        markers.add(
          Marker(
            markerId: markerId,
            position: LatLng(
                element.geometry.location.lat, element.geometry.location.lng),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
                title: element.name,
                onTap: () {},
                snippet: "Snipet ${element.name}"),
          ),
        );
      }
    }

    // markers.add(Marker(
    //     //add first marker
    //     markerId: MarkerId(showLocation.toString()),
    //     position: showLocation, //position of marker
    //     infoWindow: InfoWindow(
    //       //popup info
    //       title: 'Marker Title First ',
    //       snippet: 'My Custom Subtitle',
    //     ),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueGreen) //Icon for Marker
    //     ));

    // markers.add(Marker(
    //   //add second marker
    //   markerId: MarkerId(showLocation.toString()),
    //   position: LatLng(27.7099116, 85.3132343), //position of marker
    //   infoWindow: InfoWindow(
    //     //popup info
    //     title: 'Marker Title Second ',
    //     snippet: 'My Custom Subtitle',
    //   ),
    //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    // ));

    // markers.add(Marker(
    //   //add third marker
    //   markerId: MarkerId(showLocation.toString()),
    //   position: LatLng(27.7137735, 85.315626), //position of marker
    //   infoWindow: InfoWindow(
    //     //popup info
    //     title: 'Marker Title Third ',
    //     snippet: 'My Custom Subtitle',
    //   ),
    //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    // ));

    update();
    return markers;
  }

  addRecentCasion(CasinoResult casinoResult) {
    Get.toNamed(MyRouter.casionDetailScreen, arguments: casinoResult.casinoId);
    Utility.addRecentCasion(casinoResult);
  }

  void currentLogLat(var range) {
    Utility.getCurrentLatLong().then((value) {
      var lat = double.parse((value.latitude).toStringAsFixed(4));
      var long = double.parse((value.longitude).toStringAsFixed(4));

      getMapData(lat, long, range);
    });
  }
}
