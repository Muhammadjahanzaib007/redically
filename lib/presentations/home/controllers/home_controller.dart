import 'package:get/get.dart';
import 'package:redically_local/app/config/global_var.dart';
import 'package:redically_local/data/repositories/home_repository.dart';

import '../../../app/util/util.dart';
import '../../earn_silver/controllers/earn_silver_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  bool expandQR = false;
  var Escont = Get.put(EarnSilverController());
  final HomeRepository _repository = HomeRepository();
  RxBool loading = false.obs;
  @override
  void onInit() {
  getBalance();
    super.onInit();
  }

  Future<void> getBalance() async {
    try {
      var resp = await _repository.getBalance();
      if (resp != null && resp['status'] == "Success") {
        print(resp);
        Globals.userBalance = resp['payload']['earnedSilver'];
        loading.value = false;
        update();
      } else {
        Utils.showSnackBar(
            message: "${resp['message']}", title: '', error: true);
        loading.value = false;
      }
      update();
    } catch (e) {
      loading.value = false;
      Get.log('error of try catch : $e');
    }
  }
}
