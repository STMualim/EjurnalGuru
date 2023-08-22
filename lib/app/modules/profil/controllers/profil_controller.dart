import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_toast.dart';

class ProfilController extends GetxController {
  //TODO: Implement ProfilController
  // final Map<String, dynamic> argsData = Get.arguments;
  Map<String, dynamic> user = {};
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateProfil = false.obs;
  TextEditingController idNoC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  // TextEditingController passC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    getUser();
  }

  Future<void> getUser() async {
    String uid = auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> query =
        await firestore.collection("users").doc(uid).get();
    idNoC.text = query["idno"] ?? '';
    nameC.text = query["name"] ?? '';
    emailC.text = query["email"] ?? '';

    update();
  }

  @override
  void onReady() {
    super.onReady();

    // argsData = (Get.arguments != null) ? Get.arguments : {};
  }

  @override
  void onClose() {
    // super.onClose();
    idNoC.dispose();
    nameC.dispose();
    emailC.dispose();
  }

  Future<void> editProfil() async {
    if (idNoC.text.isNotEmpty && nameC.text.isNotEmpty) {
      isLoading.value = true;
      if (isLoadingCreateProfil.isFalse) {
        await editProfilData();
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Aduh!', 'Isiannya tidak boleh kosong');
    }
  }

  editProfilData() async {
    isLoadingCreateProfil.value = true;
    // String adminEmail = auth.currentUser!.email!;

    try {
      String uid = auth.currentUser!.uid;

      CollectionReference<Map<String, dynamic>> childrenCollection =
          await firestore.collection("users");
      await childrenCollection.doc(uid).update({
        "idno": idNoC.text,
        "name": nameC.text,

        // textformfield email hanya readonly
        // "email": emailC.text,
      });

      CustomToast.successToast('Hore!', 'Berhasil memperbarui data profil');
      isLoadingCreateProfil.value = false;
      update();
    } on FirebaseAuthException catch (e) {
      isLoadingCreateProfil.value = false;
      CustomToast.errorToast('Aduh!', 'error : ${e.code}');
    } catch (e) {
      isLoadingCreateProfil.value = false;
      CustomToast.errorToast('Aduh!', 'error : ${e.toString()}');
    }
  }
  // void increment() => count.value++;
}
