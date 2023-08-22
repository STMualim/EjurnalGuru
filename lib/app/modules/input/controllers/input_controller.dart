import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';

class InputController extends GetxController {
  //TODO: Implement InputController
  RxBool isLoading = false.obs;
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

  DateTime? date;

  File? file;
  final firebaseStorage = FirebaseStorage.instance;

  // final count = 0.obs;

  void toCamera() {
    Get.toNamed(Routes.PICK_CAMERA)!.then((result) {
      file = result;
      update();
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    dateInput.text = ""; //set the initial value of text field
  }

  Future<void> inputJurnal() async {
    if (dateInput.text.isNotEmpty) {
      isLoading.value = true;
      try {
        if (file != null) {
          var uuidJurnal = Uuid().v1();

          String fileName = file!.path.split('/').last;
          String ext = fileName.split(".").last;
          String upDir = "image/$uuidJurnal.$ext";
          var snapshot =
              await firebaseStorage.ref().child('images/$upDir').putFile(file!);
          var downloadUrl = await snapshot.ref
              .getDownloadURL(); // kitabisa get url nya untuk disimpan di firestore
          String uid = auth.currentUser!.uid;
          CollectionReference<Map<String, dynamic>> childrenCollection =
              await firestore
                  .collection("users")
                  .doc(uid)
                  .collection("jurnals");
          await childrenCollection.doc(uuidJurnal).set({
            "jurnal_id": uuidJurnal,
            // memformat isian variabel date dengan format string yang mengikuti format standar ISO 8601.
            // yyyy-MM-ddTHH:mm:ss.sssZ
            "tanggal": date!.toIso8601String(),
            // "tanggal": dateInput.text.trim(),
            "jam_ke": jam_keC.text.trim(),
            "kelas": kelasC.text.trim(),
            "mapel": mapelC.text.trim(),
            "kd": kdC.text.trim(),
            "kbm": kbmC.text.trim(),
            "non_kbm": non_kbmC.text.trim(),
            "foto": downloadUrl,
          });
          jurnal_idC.clear();
          dateInput.clear();
          jam_keC.clear();
          kelasC.clear();
          mapelC.clear();
          kdC.clear();
          kbmC.clear();
          non_kbmC.clear();
          file = null;

          CustomToast.successToast('Hore!', 'berhasil tambah data');
          isLoading.value = false;
          Get.toNamed(Routes.ALL_HOME);
        } else {
          CustomToast.errorToast('Aduh!', 'Foto wajib diisi');
        }
        /*  DocumentReference users = firestore.collection("jurnals").doc();
        await users.set({ */
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        CustomToast.errorToast('Aduh!', 'error : ${e.toString()}');
      }
    } else {
      CustomToast.errorToast('Aduh!', 'Tanggal harus diisikan');
    }
  }
}
