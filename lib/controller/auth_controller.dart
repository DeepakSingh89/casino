import 'dart:convert';
import 'dart:developer';

import 'package:casino/model/general_response.dart';
import 'package:casino/model/send_otp_response.dart';
import 'package:casino/model/signup_response.dart';
import 'package:casino/model/user_login.dart';
import 'package:casino/model/user_reset_password.dart';
import 'package:casino/model/verify_otp_response.dart';
import 'package:casino/ui/screens/login_screen.dart';
import 'package:casino/ui/screens/my_bottom_nav_screen.dart';
import 'package:casino/ui/screens/reset_password_screen.dart';
import 'package:casino/ui/screens/signup_complete_screen.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/my_singleton.dart';
import 'package:casino/utiles/utility.dart';

import '../ui/routers/my_router.dart';
import '../api_base_helper/api_base_helper.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  ApiBaseHelper _helper = ApiBaseHelper();
  var isLoading = false.obs;

  void login(String userName, String password, String firebaseId) async {
    isLoading.value = true;
    dynamic body = {
      'username': userName,
      'password': password,
      //"loginMode": "social",
      "loginMode": "general",
    };

    try {
      final response = await _helper.post("userLogin", body);
      log("response ${response}");
      UserLogin userLogin = UserLogin.fromJson(response);
      isLoading.value = false;
      if (userLogin.status == "success") {
        if (userLogin.user.activeUser) {
          Get.offAll(() => const MyBottomNavScreen());
          Utility.saveUserInfoLogin(
              userLogin.user, userLogin.token, response, userLogin.ads);
        } else {
          Utility.showError(userLogin.message);
        }
      } else {
        Utility.showError(userLogin.message);
      }
    } catch (e) {
      // Utility.showError(e.toString());
      Utility.showError("Login Failed");
      log("login Error : ${e.toString()}");
      e.printError();
      isLoading.value = false;
    }
  }

  void signup(
    String username,
    String email,
    String mobileNo,
    String password,
    String location,
    String language,
    String deviceToken,
    String image,
  ) async {
    isLoading.value = true;
    // List<double> loactions = [
    //   MySingleton.shared.location.keys.first,
    //   MySingleton.shared.location.values.first
    // ];
    dynamic body = {
      'username': username,
      'email': email,
      'mobileNo': "8145628647",
      'password': password,
      //'location': "",
      'language': language,
      'deviceToken': deviceToken,
      'image': 'data:image/png;base64,$image',
      'long': MySingleton.shared.location.keys.first.toString(),
      'lat': MySingleton.shared.location.values.first.toString()
    };
    // var bodyJsonEncode = jsonEncode(body);
    log(body.toString());
    try {
      final response = await _helper.post("register", (body));

      print(" response ${response}");
      final signupResponse = SignupResponse.fromJson(response);
      isLoading.value = false;
      if (signupResponse.status == "success") {
        //Utility.saveUserInfoSignup(signupResponse.user, signupResponse.token);
        Get.offAll(() => const SignupCompleteScreen());
      } else {
        print("Error : ${signupResponse.message}");
        Utility.showError(signupResponse.message);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      isLoading.value = false;
      // Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
    }
  }

  void reSendOTP(String email) async {
    isLoading.value = true;
    dynamic body = {
      'email': email,
    };

    try {
      final response = await _helper.post("email/send-otp", (body));
      SendOtpResponse sendOtpResponse = SendOtpResponse.fromJson(response);
      isLoading.value = false;
      if (sendOtpResponse.status == "success") {
        Utility.showInfo(sendOtpResponse.message);
      } else {
        Utility.showError(sendOtpResponse.message);
      }
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
    }
  }

  void sendOTP(String email) async {
    isLoading.value = true;
    dynamic body = {
      'email': email,
    };

    try {
      final response = await _helper.post("email/send-otp", (body));
      SendOtpResponse sendOtpResponse = SendOtpResponse.fromJson(response);
      isLoading.value = false;
      if (sendOtpResponse.status == "success") {
        // Get.toNamed(MyRouter.emailVerifyScreen);
        Get.offAndToNamed(MyRouter.emailVerifyScreen);
      } else {
        Utility.showError(sendOtpResponse.message);
      }
    } catch (e) {
      print(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      // Utility.showError(e.toString());
      isLoading.value = false;
    }
  }

  void verifyOtp(String email, String otp) async {
    isLoading.value = true;
    dynamic body = {'email': email, 'otp': otp};

    try {
      final response = await _helper.post("email/verify-otp", (body));
      log("response :  $response");
      VerifyOtpResponse verifyOtpResponse =
          VerifyOtpResponse.fromJson(response);
      isLoading.value = false;
      if (verifyOtpResponse.status == "success") {
        // Get.toNamed(MyRouter.addProfilePicScreen);
        Get.offAndToNamed(MyRouter.addProfilePicScreen);
      } else {
        Utility.showError(verifyOtpResponse.message);
      }
    } catch (e) {
      print(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoading.value = false;
    }
  }

  void forgotPasswordSenOTP(String email) async {
    isLoading.value = true;
    dynamic body = {
      'email': email,
    };

    try {
      final response = await _helper.post("email/send-otp", (body));
      SendOtpResponse sendOtpResponse = SendOtpResponse.fromJson(response);
      isLoading.value = false;
      if (sendOtpResponse.status == "success") {
        MySingleton.shared.email = email;
        //  Get.toNamed(MyRouter.resetPasswordScreen);
        Get.offAll(() => const ResetPasswordScreen());
      } else {
        Utility.showError(sendOtpResponse.message);
      }
    } catch (e) {
      print(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      //Utility.showError(e.toString());
      isLoading.value = false;
    }
  }

  void resetPassword(String email, String otp, String password) async {
    isLoading.value = true;
    dynamic body = {'email': email, 'otp': otp, 'password': password};

    try {
      final response = await _helper.post("email/userResetPassword", (body));
      UserResetPassword userResetPassword =
          UserResetPassword.fromJson(response);
      isLoading.value = false;
      if (userResetPassword.Status == "success") {
        Utility.showInfo(userResetPassword.message);
        Get.offAll(() => const LoginScreen());
      } else {
        Utility.showError(userResetPassword.message);
      }
    } catch (e) {
      print(e.toString());
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    //mobileTextController?.dispose();
    super.onClose();
  }

  void changePassword(
      String userID, String newPassword, String oldPassword) async {
    isLoading.value = true;
    dynamic body = {
      'cpassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': newPassword,
      'userId': userID
    };

    try {
      final response = await _helper.post("user/change-password", (body));
      UserResetPassword generalResponse = UserResetPassword.fromJson(response);
      isLoading.value = false;
      if (generalResponse.Status == "success") {
        Utility.showInfo(generalResponse.message);
        Get.offAndToNamed(MyRouter.settingScreen);
        //Get.toNamed(MyRouter.settingScreen);
        //Get.offAll(() => const LoginScreen());
      } else {
        // Utility.showError(generalResponse.message);
      }
    } catch (e) {
      print(e.toString());
      //Utility.showError(e.toString());
      Utility.showError(Constant.SERVER_ERROR);
      isLoading.value = false;
    }
  }
}
