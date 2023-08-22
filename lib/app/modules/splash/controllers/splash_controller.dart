import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guru_ejurnal/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  // cek auth login user apakah sudah pernah login
  final box = GetStorage();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    // display splashscreen
    Future.delayed(const Duration(seconds: 3), () {
      // cek auth login user apakah sudah pernah login
      // jika sdh pernah maka dari splash langsung ke ALL HOME
      // jika belum pernah maka ke halaman login dulu
      if (box.read('isLogin') ?? false) {
        Get.offNamed(Routes.ALL_HOME);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
