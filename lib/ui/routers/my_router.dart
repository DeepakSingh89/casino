import 'package:casino/ui/screens/add_password_screen.dart';
import 'package:casino/ui/screens/add_profile_pic_screen.dart';
import 'package:casino/ui/screens/casion_detail_screen.dart';
import 'package:casino/ui/screens/casion_map_screen.dart';
import 'package:casino/ui/screens/casion_user_review_screen.dart';
import 'package:casino/ui/screens/change_password_screen.dart';
import 'package:casino/ui/screens/email_enter_screen.dart';
import 'package:casino/ui/screens/email_verify_screen.dart';
import 'package:casino/ui/screens/favorite_casion_screen.dart';
import 'package:casino/ui/screens/forget_password_screen.dart';
import 'package:casino/ui/screens/forum_comment_screen.dart';
import 'package:casino/ui/screens/game_card_screen.dart';
import 'package:casino/ui/screens/game_max_min_set.dart';
import 'package:casino/ui/screens/game_max_min_set_complete.dart';
import 'package:casino/ui/screens/game_select_casion.dart';
import 'package:casino/ui/screens/general_screen_privacy_policy.dart';
import 'package:casino/ui/screens/general_screen_term_condition.dart';
import 'package:casino/ui/screens/language_select_screen.dart';
import 'package:casino/ui/screens/location_permission_screen.dart';
import 'package:casino/ui/screens/login_screen.dart';
import 'package:casino/ui/screens/my_bottom_nav_screen.dart';
import 'package:casino/ui/screens/profile_screen.dart';
import 'package:casino/ui/screens/recent_casion_screen.dart';
import 'package:casino/ui/screens/reset_password_screen.dart';
import 'package:casino/ui/screens/reward_screen.dart';
import 'package:casino/ui/screens/reward_screen_detail.dart';
import 'package:casino/ui/screens/setting_screen.dart';
import 'package:casino/ui/screens/signup_complete_screen.dart';
import 'package:casino/ui/screens/splash_screen.dart';
import 'package:casino/ui/screens/startup_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MyRouter {
  static var locationPermissionScreen = "/locationPermissionScreen";
  static var languageSelectScreen = "/languageSelectScreen";
  static var userCreationScreen = "/userCreationScreen";
  static var emailEnterScreen = "/emailEnterScreen";
  static var emailVerifyScreen = "/emailVerifyScreen";
  static var addProfilePicScreen = "/addProfilePicScreen";
  static var signupCompleteScreen = "/signupCompleteScreen";
  static var startupScreen = "/startupScreen";
  static var loginScreen = "/loginScreen";
  static var profileScreen = "/profileScreen";
  static var addPasswordScreen = "/AddPasswordScreen";
  static var myBottomNavScreen = "/myBottomNavScreen";
  static var casionDetailScreen = "/casionDetailScreen";
  static var gameSelectCasion = "/gameSelectCasion";
  static var gameCardScreen = "/gameCardScreen";
  static var gameMaxMinSet = "/gameMaxMinSet";
  static var gameMAxMinSetComplete = "/gameMAxMinSetComplete";
  static var rewardScreen = "/rewardScreen";
  static var forgetPasswordScreen = "/forgetPasswordScreen";
  static var resetPasswordScreen = "/resetPasswordScreen";
  static var favoriteCasio = "/favoriteCasio";
  static var settingScreen = "/settingScreen";
  static var recentCasionScreen = "/recentCasionScreen";
  static var casionUserReviewScreen = "/casionUserReviewScreen";
  static var changePasswordScreen = "/changePasswordScreen";
  static var casionMapScreen = "/casionMapScreen";
  static var forumCommentScreen = "/forumCommentScreen";
  static var generalScreenTermCondition = "/generalScreenTermCondition";
  static var generalScreenPrivacyPolicy = "/generalScreenPrivacyPolicy";
  static var rewardScreenDetail = "/rewardScreenDetail";

  static var route = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(
        name: MyRouter.locationPermissionScreen,
        page: () => const LocationPermissionScreen()),
    GetPage(
        name: MyRouter.languageSelectScreen,
        page: () => const LanguageSelectScreen()),
    GetPage(
        name: MyRouter.emailEnterScreen, page: () => const EmailEnterScreen()),
    GetPage(
        name: MyRouter.emailVerifyScreen,
        page: () => const EmailVerifyScreen()),
    GetPage(
        name: MyRouter.addProfilePicScreen,
        page: () => const AddProfilePicScreen()),
    GetPage(
        name: MyRouter.signupCompleteScreen,
        page: () => const SignupCompleteScreen()),
    GetPage(name: MyRouter.startupScreen, page: () => const StartupScreen()),
    GetPage(name: MyRouter.loginScreen, page: () => const LoginScreen()),
    GetPage(name: MyRouter.profileScreen, page: () => const ProfileScreen()),
    GetPage(
        name: MyRouter.addPasswordScreen,
        page: () => const AddPasswordScreen()),
    GetPage(
        name: MyRouter.myBottomNavScreen,
        page: () => const MyBottomNavScreen()),
    GetPage(
        name: MyRouter.casionDetailScreen,
        page: () => const CasionDetailScreen()),
    GetPage(
        name: MyRouter.gameSelectCasion, page: () => const GameSelectCasion()),
    GetPage(name: MyRouter.gameCardScreen, page: () => const GameCardScreen()),
    GetPage(name: MyRouter.gameMaxMinSet, page: () => const GameMaxMinSet()),
    GetPage(
        name: MyRouter.gameMAxMinSetComplete,
        page: () => const GameMAxMinSetComplete()),
    GetPage(name: MyRouter.rewardScreen, page: () => const RewardScreen()),
    GetPage(
        name: MyRouter.forgetPasswordScreen,
        page: () => const ForgetPasswordScreen()),
    GetPage(
        name: MyRouter.resetPasswordScreen,
        page: () => const ResetPasswordScreen()),
    GetPage(
        name: MyRouter.favoriteCasio, page: () => const FavoriteCasionScreen()),
    GetPage(name: MyRouter.settingScreen, page: () => const SettingScreen()),
    GetPage(
        name: MyRouter.recentCasionScreen,
        page: () => const RecentCasionScreen()),
    GetPage(
        name: MyRouter.casionUserReviewScreen,
        page: () => const CasionUserReviewScreen()),
    GetPage(
        name: MyRouter.changePasswordScreen,
        page: () => const ChangePasswordScreen()),
    GetPage(
        name: MyRouter.casionMapScreen, page: () => const CasionMapScreen()),
    GetPage(
        name: MyRouter.forumCommentScreen,
        page: () => const ForumCommentScreen()),
    GetPage(
        name: MyRouter.generalScreenTermCondition,
        page: () => const GeneralScreenTermCondition()),
    GetPage(
        name: MyRouter.generalScreenPrivacyPolicy,
        page: () => const GeneralScreenPrivacyPolicy()),
    GetPage(
        name: MyRouter.rewardScreenDetail,
        page: () => const RewardScreenDetail()),
  ];
}
