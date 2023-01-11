import 'package:get/get.dart';

import '../controllers/earn_silver_controller.dart';

class EarnSilverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarnSilverController>(
      () => EarnSilverController(),
    );
  }
}
