import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthenticationController>(
    //   () => AuthenticationController(),
    // );
    Get.log('AuthenticationBinding.dependencies');
    Get.put(AuthenticationController(), permanent: true);
  }
}
