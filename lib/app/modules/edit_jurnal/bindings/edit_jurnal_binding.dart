import 'package:get/get.dart';

import '../controllers/edit_jurnal_controller.dart';

class EditJurnalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditJurnalController>(
      () => EditJurnalController(),
    );
  }
}
