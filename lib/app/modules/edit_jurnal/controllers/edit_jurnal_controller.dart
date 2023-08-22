import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';

class EditJurnalController extends GetxController {
  //TODO: Implement EditJurnalController
  RxString image = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateJurnal = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController jurnal_idC = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController jam_keC = TextEditingController();
  TextEditingController kelasC = TextEditingController();
  TextEditingController mapelC = TextEditingController();
  TextEditingController kdC = TextEditingController();
  TextEditingController kbmC = TextEditingController();
  TextEditingController non_kbmC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final argsData = Get.arguments;
  // final Map<String, dynamic> argsData_1 = Get.arguments;
  File? file;
  final firebaseStorage = FirebaseStorage.instance;
  // final count = 0.obs;
  DateTime? date;

  void toCamera() {
    Get.toNamed(Routes.PICK_CAMERA)!.then((result) {
      file = result;
      update();
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    DateTime tgl = DateTime.parse(argsData["tanggal"]);
    // dateInput.text = argsData["tanggal"];
    dateInput.text = DateFormat('dd/MM/yyyy').format(tgl);
    jam_keC.text = argsData["jam_ke"];
    kelasC.text = argsData["kelas"];
    mapelC.text = argsData["mapel"];
    kdC.text = argsData["kd"];
    kbmC.text = argsData["kbm"];
    non_kbmC.text = argsData["non_kbm"];
    image.value = argsData["foto"];
  }

  Future<void> cekJurnal() async {
    if (dateInput.text.isNotEmpty) {
      isLoading.value = true;
      if (isLoadingCreateJurnal.isFalse) {
        await updateJurnalData();
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Aduh!', 'Isi dulu formnya');
    }
  }

  updateJurnalData() async {
    isLoadingCreateJurnal.value = true;
    // String adminEmail = auth.currentUser!.email!;
    try {
      Map<String, dynamic> data = {
        // memformat inputan dari dateinput yang berformat dd/MM/yyyy menjadi format string yang mengikuti format standar ISO 8601
        "tanggal":
            DateFormat('dd/MM/yyyy').parse(dateInput.text).toIso8601String(),

        "jam_ke": jam_keC.text.trim(),
        "kelas": kelasC.text.trim(),
        "mapel": mapelC.text.trim(),
        "kd": kdC.text.trim(),
        "kbm": kbmC.text.trim(),
        "non_kbm": non_kbmC.text.trim(),
        // "foto": downloadUrl,
      };
      if (file != null) {
        String fileName = file!.path.split('/').last;
        String ext = fileName.split(".").last;
        String upDir = "image/${argsData['jurnal_id']}.$ext";
        var snapshot =
            await firebaseStorage.ref().child('images/$upDir').putFile(file!);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        data["foto"] = downloadUrl;
      }
      // log(json.encode(data));
      String uid = auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> childrenCollection =
          await firestore.collection("users").doc(uid).collection("jurnals");
      await childrenCollection.doc(argsData["jurnal_id"]).update(data);
      Get.back(); //close dialog
      // Get.back(); //close form screen
      CustomToast.successToast('Hore!', 'Berhasil memperbarui jurnal');

      isLoadingCreateJurnal.value = false;
    } on FirebaseAuthException catch (e) {
      isLoadingCreateJurnal.value = false;
      CustomToast.errorToast('Aduh!', 'error : ${e.code}');
    } catch (e) {
      isLoadingCreateJurnal.value = false;
      CustomToast.errorToast('Aduh!', 'error : ${e.toString()}');
    }
  }

  /* @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++; */
}
