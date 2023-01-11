import 'package:get/get.dart';

import '../controllers/silver_balance_controller.dart';

class SilverBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SilverBalanceController>(
      () => SilverBalanceController(),
    );
  }
}
