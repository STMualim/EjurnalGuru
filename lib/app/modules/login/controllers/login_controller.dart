import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // cek auth login user apakah sudah pernah login
  final box = GetStorage();

  // fungsi login
  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      // login firebase dengan email dan password
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passC.text,
        );

        // mengecek pengguna ada atau tidaknya

        if (credential.user != null) {
          // membaca atuh login firebase
          box.write('isLogin', true);
          // ini optional
          /* String uid = auth.currentUser!.uid;
          DocumentSnapshot<Map<String, dynamic>> query =
              await firestore.collection("users").doc(uid).get(); */
          Get.offAllNamed(Routes.ALL_HOME);
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          CustomToast.errorToast("Aduh!", "Akun tidak ditemukan");
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast("Aduh!", "Password salah");
        }
      } catch (e) {
        CustomToast.errorToast("Aduh!", "Error dikarenakan :${e.toString()}");
      }
    } else {
      CustomToast.errorToast(
          "Aduh!", "Anda harus mengisikan email dan password");
    }
  }
}


/* import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
 */