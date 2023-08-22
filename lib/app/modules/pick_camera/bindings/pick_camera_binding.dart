import 'package:get/get.dart';

import '../controllers/pick_camera_controller.dart';

class PickCameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickCameraController>(
      () => PickCameraController(),
    );
  }
}
