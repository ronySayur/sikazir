import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/routes/app_pages.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Ambil data pegawai sekarang yang login
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }



  Future<void> signOut() async {
    await auth.signOut();
    Get.toNamed(Routes.LOGIN);
    Get.snackbar("Berhasil", "Anda berhasil Logout");
  }

//First Initial
  Future<void> firstInitialized() async {
    //mengubah isSkip => true
    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

//Skip Introduction
  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  }
}
