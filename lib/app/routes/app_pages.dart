import 'package:get/get.dart';

import '../modules/all_home/bindings/all_home_binding.dart';
import '../modules/all_home/views/all_home_view.dart';
import '../modules/edit_jurnal/bindings/edit_jurnal_binding.dart';
import '../modules/edit_jurnal/views/edit_jurnal_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/input/bindings/input_binding.dart';
import '../modules/input/views/input_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notif/bindings/notif_binding.dart';
import '../modules/notif/views/notif_view.dart';
import '../modules/pick_camera/bindings/pick_camera_binding.dart';
import '../modules/pick_camera/views/pick_camera_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_pass/bindings/reset_pass_binding.dart';
import '../modules/reset_pass/views/reset_pass_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.SPLASH,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: Transition.fade),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding(),
        transition: Transition.leftToRight),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding(),
        transition: Transition.leftToRight),
    GetPage(
      name: _Paths.ALL_HOME,
      page: () => const AllHomeView(),
      binding: AllHomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.NOTIF,
      page: () => const NotifView(),
      binding: NotifBinding(),
    ),
    GetPage(
      name: _Paths.INPUT,
      page: () => const InputView(),
      binding: InputBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: RiwayatBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PICK_CAMERA,
      page: () => const PickCameraView(),
      binding: PickCameraBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASS,
      page: () => const ResetPassView(),
      binding: ResetPassBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.EDIT_JURNAL,
      page: () => const EditJurnalView(),
      binding: EditJurnalBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
