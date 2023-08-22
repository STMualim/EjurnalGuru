import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guru_ejurnal/app/routes/app_pages.dart';

import '../../../widgets/custom_toast.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  RxBool obsecureText_1 = true.obs;
  TextEditingController idNoC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController uPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> registration() async {
    if (passC.text.trim() != uPassC.text.trim()) {
      CustomToast.errorToast('Aduh!', 'Re-type password tidak sama');
    } else {
      if (passC.text.isNotEmpty) {
        isLoading.value = true;
        try {
          // if the password is match, then continue the create user process
          UserCredential respondentCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailC.text.trim(),
            password: passC.text.trim(),
          );
          if (respondentCredential.user != null) {
            String uid = respondentCredential.user!.uid;
            DocumentReference users = firestore.collection("users").doc(uid);
            await users.set({
              "user_id": uid,
              "idno": idNoC.text,
              "name": nameC.text,
              "email": emailC.text.trim(),
              "created_at": DateTime.now().toIso8601String(),
            });
            await respondentCredential.user!.sendEmailVerification();
            //need to logout because the current user is changed after adding new user
            auth.signOut();
            // need to relogin to admin account
            await auth.signInWithEmailAndPassword(
                email: emailC.text.trim(), password: passC.text);
            Get.back(); //close dialog
            Get.back(); //close form screen
            CustomToast.successToast('Hore!', 'berhasil mendaftar');
            isLoading.value = false;
            Get.offNamed(Routes.LOGIN);
          }
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          if (e.code == 'weak-password') {
            CustomToast.errorToast('Aduh!', 'password terlalu pendek');
          } else if (e.code == 'email-already-in-use') {
            CustomToast.errorToast('Aduh!', 'Email sudah terdaftar');
          } else if (e.code == 'wrong-password') {
            CustomToast.errorToast('Aduh!', 'Password salah');
          } else {
            CustomToast.errorToast('Aduh!', 'error : ${e.code}');
          }
        } catch (e) {
          isLoading.value = false;
          CustomToast.errorToast('Aduh!', 'error : ${e.toString()}');
        }
      } else {
        CustomToast.errorToast('Aduh!', 'Password tidak boleh kosong');
      }
    }
  }
}


/* import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

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