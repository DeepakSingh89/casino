import 'package:casino/controller/auth_controller.dart';
import 'package:casino/controller/casion_controller.dart';
import 'package:casino/controller/general_controller.dart';
import 'package:casino/controller/map_controller.dart';
import 'package:casino/controller/review_controller.dart';
import 'package:get/get.dart';

class BindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<GeneralController>(GeneralController());
    Get.put<CasionController>(CasionController());
    Get.put<ReviewController>(ReviewController());
  }
}
