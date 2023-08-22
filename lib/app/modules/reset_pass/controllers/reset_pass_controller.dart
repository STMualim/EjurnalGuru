import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guru_ejurnal/app/widgets/custom_toast.dart';

import '../../../routes/app_pages.dart';

class ResetPassController extends GetxController {
  //TODO: Implement ResetPassController
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> reset() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(
          email: emailC.text.trim(),
        );
        CustomToast.successToast(
            "Hore!", "Link reset password telah dikirim ke e-mail");
        Get.offAllNamed(Routes.LOGIN);

        /* if (credential != null) {

        } */
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          CustomToast.errorToast("Aduh!", "Akun tidak ditemukan");
        }
      } catch (e) {
        CustomToast.errorToast("Aduh!", "Error dikarenakan : ${e.toString()}");
      }
    } else {
      CustomToast.errorToast("Aduh!", "Isian email masih kosong");
    }
  }

/*
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++; */
}
