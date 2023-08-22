import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guru_ejurnal/app/modules/home/views/home_view.dart';
import 'package:guru_ejurnal/app/modules/notif/views/notif_view.dart';
import 'package:guru_ejurnal/app/modules/profil/views/profil_view.dart';
import 'package:guru_ejurnal/app/routes/app_pages.dart';
import 'package:guru_ejurnal/app/widgets/custom_alert_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AllHomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  // cek auth login user apakah sudah pernah login
  final box = GetStorage();

  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  List<Widget> buildScreens() {
    return [HomeView(), NotifView(), ProfilView(), Container()];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.house_rounded),
        title: ("Home"),
        activeColorPrimary: Color.fromARGB(255, 5, 61, 107),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.circle_notifications_rounded),
        title: ("Notif"),
        activeColorPrimary: Color.fromARGB(255, 5, 61, 107),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_box_rounded),
        title: ("Profil"),
        activeColorPrimary: Color.fromARGB(255, 5, 61, 107),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (c) => CustomAlertDialog.showPresenceAlert(
            title: "Konfirmasi Keluar",
            message: "Apakah anda yakin keluar?",
            onConfirm: () {
              auth.signOut();
              box.remove('isLogin');
              Get.offAllNamed(Routes.LOGIN);
            },
            onCancel: () => Get.back()),
        icon: Icon(Icons.logout_rounded),
        title: ("Keluar"),
        activeColorPrimary: Color.fromARGB(255, 5, 61, 107),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
