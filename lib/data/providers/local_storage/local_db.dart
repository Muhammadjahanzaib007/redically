import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/config/global_var.dart';

class LocalDB extends GetxService {
  late SharedPreferences pref;
  @override
  void onInit() async {
    pref = await SharedPreferences.getInstance();
    Get.log("LocalDB Controller init called : Service Started");
    Globals.authToken = pref.getString("token") ?? "";
    Globals.refreshToken = pref.getString("refreshToken") ?? "";

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.id}');
      Globals.deviceId = androidInfo.id;
      Globals.loginDevice = "Android";
      Globals.appVersion = packageInfo.version;
    } // e.g. "Moto G (4)"
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.identifierForVendor}');
      Globals.deviceId = iosInfo.identifierForVendor;
      Globals.loginDevice = "IOS";
      Globals.appVersion = packageInfo.version;
    }
    // Future.delayed(Duration(seconds: 3)).then((value) =>Get.offAndToNamed(Routes.AUTHENTICATION));
    Globals.email = pref.getString("email");

    Globals.phoneNumber = pref.getString("phoneNumber");
    Globals.userId = pref.getString("userId") ?? "";
    if (Globals.email != null && Globals.email!.isEmpty) {
      Globals.email = null;
    }
    if (Globals.phoneNumber != null && Globals.phoneNumber!.isEmpty) {
      Globals.phoneNumber = null;
    }
    Globals.firstTime = pref.getBool('first') ?? false;
    super.onInit();
  }

  static void setData(String key, value) async {
    SharedPreferences pref = Get.find<LocalDB>().pref;
    switch (value.runtimeType) {
      case int:
        pref.setInt(key, value);
        break;
      case String:
        pref.setString(key, value);
        break;
      case bool:
        pref.setBool(key, value);
        break;
      case double:
        pref.setDouble(key, value);
        break;
      case List<String>:
        pref.setStringList(key, value);
        break;
    }
  }

  static dynamic getData(String key, {type}) async {
    SharedPreferences pref = Get.find<LocalDB>().pref;
    if (type != null) {
      return pref.getStringList(key);
    }
    return pref.get(key);
  }

  static void clear() async {
    SharedPreferences pref = Get.find<LocalDB>().pref;
    bool first = pref.getBool("first") ?? false;

    Globals.userId = "";
    Globals.fcmToken = "";
    Globals.authToken = "";
    pref.remove(Globals.authToken);
    await pref.clear();
    if (first) {
      pref.setBool("first", true);
    }
  }
}
