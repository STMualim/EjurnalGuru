import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
// import 'package:file_saver/file_saver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_toast.dart';

class RiwayatController extends GetxController {
  //TODO: Implement RiwayatController
  // final Map<String, dynamic> argsData = Get.arguments;
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController jurnal_idC = TextEditingController();
  TextEditingController dateInputAwal = TextEditingController();
  TextEditingController dateInputAkhir = TextEditingController();
  TextEditingController jam_keC = TextEditingController();
  TextEditingController kelasC = TextEditingController();
  TextEditingController mapelC = TextEditingController();
  TextEditingController kdC = TextEditingController();
  TextEditingController kbmC = TextEditingController();
  TextEditingController non_kbmC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? start;
  DateTime end = DateTime.now();
  String kosong = "";
  final count = 1.obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamJurnal() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("jurnals")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastJurnal() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("jurnals")
        .orderBy("tanggal", descending: true)
        .limitToLast(10)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllResult() async* {
    String uid = auth.currentUser!.uid;
    if (start == null) {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("jurnals")
          .where("tanggal",
              isLessThan:
                  DateFormat('dd-MM-yyyy').format(end.add(Duration(days: 1))))
          .orderBy(
            "tanggal",
            descending: true,
          )
          // .limitToLast(10)
          .snapshots();
    } else {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("jurnals")
          // .where("tanggal",
          //     isGreaterThan: DateFormat('dd-MM-yyyy')
          //         .format(start!.add(Duration(days: -1))))
          .where("tanggal",
              isGreaterThan: start!.add(Duration(days: -1)).toIso8601String())
          // .where("tanggal",
          //     isLessThan:
          //         DateFormat('dd-MM-yyyy').format(end.add(Duration(days: 1))))
          .where("tanggal",
              isLessThan: end.add(Duration(days: 1)).toIso8601String())
          .orderBy(
            "tanggal",
            descending: true,
          )
          // .limitToLast(5)
          .snapshots();
      // yield* firestore
      //     .collection("users")
      //     .doc(uid)
      //     .collection("jurnals")
      //     .where("tanggal", isGreaterThan: start!.toIso8601String())
      //     .where("tanggal",
      //         isLessThan: end.add(Duration(days: 1)).toIso8601String())
      //     .orderBy(
      //       "tanggal",
      //       descending: true,
      //     )
      //     .snapshots();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    print(start);
    print(end);

    update();
    Get.back();
  }

  Future<List<int>> readImageData(String name) async {
    final ByteData data = await rootBundle.load('assets/images/usr.png');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    String uid = auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> user =
        await firestore.collection("users").doc(uid).get();
    return user;
  }

  // var creationDate = data['creationDate'].toDate();
  Future<void> exportDataToExcel() async {
    String uid = auth.currentUser!.uid;
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // QuerySnapshot snapshot = await firestore.collection('users').get();
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (start == null) {
      snapshot = await firestore
          .collection("users")
          .doc(uid)
          .collection('jurnals')
          .where("tanggal",
              isLessThan:
                  DateFormat('dd-MM-yyyy').format(end.add(Duration(days: 1))))
          .orderBy(
            "tanggal",
            descending: false,
          )
          .get();
    } else {
      snapshot = await firestore
          .collection("users")
          .doc(uid)
          .collection('jurnals')
          // .where("tanggal",
          //     isGreaterThan: DateFormat('dd-MM-yyyy')
          //         .format(start!.add(Duration(days: -1))))
          .where("tanggal",
              isGreaterThan: start!.add(Duration(days: -1)).toIso8601String())
          // .where("tanggal",
          //     isLessThan:
          //         DateFormat('dd-MM-yyyy').format(end.add(Duration(days: 1))))
          .where("tanggal",
              isLessThan: end.add(Duration(days: 1)).toIso8601String())
          .orderBy(
            "tanggal",
            descending: false,
          )
          .get();
    }

    // Create a header row

    // final String header =
    //     base64.encode(await readImageData('assets/images/usr.png'));
    // sheet.appendRow([header]);

    DocumentSnapshot<Map<String, dynamic>> user = await getUser();

    sheet.appendRow(['Nama Guru : ${user.data()!["name"]}']);
    sheet.appendRow(['NIP/NUPTK : ${user.data()!["idno"]}']);
    sheet.appendRow(['Periode :']);
    sheet.appendRow([
      'No',
      'Tanggal',
      'Jam Ke',
      'Kelas',
      'Mapel',
      'KD',
      'Kegiatan kbm',
      'Kegiatan Non kbm',
      'Link Foto'
    ]);

    List<Map<String, dynamic>> datas = [
      {'idno': 1, 'name': 'aa', 'email': 'aa@gmail.com'},
      {'idno': 2, 'name': 'bb', 'email': 'bb@gmail.com'},
      {'idno': 3, 'name': 'cc', 'email': 'cc@gmail.com'},
    ];

    // Fill the sheet with Firestore data
    int i = 1;
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      sheet.appendRow([
        i,
        DateFormat('dd/MM/yyyy').format(DateTime.parse(data['tanggal'])),
        data['jam_ke'],
        data['kelas'],
        data['mapel'],
        data['kd'],
        data['kbm'],
        data['non_kbm'],
        data['foto']
      ]);
      i++;
    }

    // Save the Excel file
    List<int>? excelData = excel.encode();

    // Get the directory where we can save files
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    // Create a new Excel file
    String excelFilePath = '${appDocumentsDirectory.path}/excel_file.xlsx';
    // await File(excelFilePath).writeAsBytes(excelData!);
    // String path = await FileSaver.instance.saveFile(
    //     name: "File",
    //     //link:  linkController.text,
    //     bytes: Uint8List.fromList(excel.encode()!),
    //     ext: 'xlsx',

    //     ///extController.text,
    //     mimeType: MimeType.microsoftExcel);
    String path = await FlutterFileSaver().writeFileAsBytes(
      fileName: 'file.xlsx',
      bytes: Uint8List.fromList(excel.encode()!),
    );
    log(path);
  }

  Future<void> deleteJurnal(String id) async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data jurnal",
      message: "Apakah anda ingin menghapus data jurnal ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        Get.back(); // close modal
        // Get.back(); // back page
        try {
          String uid = auth.currentUser!.uid;
          await firestore
              .collection('users')
              .doc(uid)
              .collection('jurnals')
              .doc(id)
              .delete();
          CustomToast.successToast('Hore!', 'Data jurnal berhasil dihapus');
        } catch (e) {
          CustomToast.errorToast(
              "Aduh!", "Error dikarenakan : ${e.toString()}");
        }
      },
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

// ...

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
