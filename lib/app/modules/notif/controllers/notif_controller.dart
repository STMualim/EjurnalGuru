import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class NotifController extends GetxController {
  //TODO: Implement NotifController
  RxBool isloading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamCollection() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("notifs").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotif() async* {
    //  String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("notifs")
        .orderBy("date", descending: true)
        .limitToLast(10)
        .snapshots();
  }

  /* final count = 0.obs;
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

  void increment() => count.value++; */
}
