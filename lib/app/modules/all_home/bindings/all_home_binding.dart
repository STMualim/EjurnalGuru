import 'package:get/get.dart';

import '../controllers/all_home_controller.dart';

class AllHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllHomeController>(
      () => AllHomeController(),
    );
  }
}
