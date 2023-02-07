import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/routes/app_pages.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  final box = GetStorage();
  var isAuth = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Ambil data pegawai sekarang yang login
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.email!;

    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  Future<void> signOut() async {
    await auth.signOut();
    await box.remove('userEmail');
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
    var read = box.read('skipIntro');
    print(read);
    if (read != null || read == true) {
      return true;
    }
    return false;
  }
}
