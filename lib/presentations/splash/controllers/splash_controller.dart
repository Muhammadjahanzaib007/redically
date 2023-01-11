import 'dart:async';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:redically_local/data/providers/local_storage/local_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/config/app_string.dart';
import '../../../app/config/global_var.dart';
import '../../../app/routes/app_pages.dart';
import '../../authentication/controllers/authentication_controller.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  var con = Get.put(LocalDB());
  @override
  onInit() async {
    await appUpdateCheck();
    super.onInit();
  }

  Future appUpdateCheck() async {
    await getlocalData().then((value) async {
      final con = Get.put(AuthenticationController());
      if (Globals.authToken != "") {
        if (Globals.refreshToken != "") {
          bool hasExpired = JwtDecoder.isExpired(Globals.authToken);
          print("hasExpired$hasExpired");
          if (hasExpired) {
            await con.refreshToken();
          }
          if ((Globals.isLocalEmployed && !Globals.workHistoryStatus) ||
              (Globals.isLocalResident && !Globals.residenceProofStatus)) {
            Timer(
                const Duration(seconds: 3), () => Get.offNamed(Routes.LANDING));
          } else {
            Timer(const Duration(seconds: 3), () => Get.offNamed(Routes.HOME));
          }
        } else {
          Timer(const Duration(seconds: 3), () => Get.offNamed(Routes.LANDING));
        }
      } else {
        Get.log(
            'SplashController.appUpdateCheck for token ${Globals.authToken} ');
        Timer(const Duration(seconds: 3), () => Get.offNamed(Routes.LANDING));
      }
    });
  }

  Future<void> getlocalData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Globals.authToken = pref.getString(AppStrings.token) ?? "";
    Globals.userId = pref.getString(AppStrings.userId) ?? "";
    Globals.refreshToken = pref.getString(AppStrings.refreshToken) ?? "";
    Globals.name = pref.getString(AppStrings.name);
    Globals.email = pref.getString(AppStrings.email);
    Globals.isLocalResident = pref.getBool(AppStrings.isLocalResident) ?? false;
    Globals.isLocalEmployed = pref.getBool(AppStrings.isLocalEmployed) ?? false;
    Globals.residenceProofStatus =
        pref.getBool(AppStrings.residenceProofStatus) ?? false;
    Globals.workHistoryStatus =
        pref.getBool(AppStrings.workHistoryStatus) ?? false;
    update();
  }


}
