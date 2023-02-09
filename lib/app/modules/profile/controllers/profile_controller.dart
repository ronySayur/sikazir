import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Ambil data pegawai Pegawai
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String email = box.read('userEmail');

    yield* firestore.collection("pegawai").doc(email).snapshots();
  }

  //Controller Logout
  Future<void> logout() async {
    await box.remove('jabatan');
    await box.remove('userEmail');
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
