import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/controllers/auth_controller.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> newPaswword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "111111") {
        try {
          loading();
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPassC.text);

          await firestore
              .collection("pegawai")
              .doc(email)
              .update({"pin": newPassC.text});

          await auth.signOut();

          Get.snackbar("Pemberitahuan",
              "Silahkan login sekali lagi dengan password baru anda");
          Get.back();

          Get.offAllNamed(Routes.LOGIN);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Peringatan",
                "Password yang digunakan terlalu lemah(minimal 6 karakter)");
          } else if (e.code == 'email-already-in-use') {
            Get.snackbar("Peringatan", "Akun sudah ada");
          }
        } catch (e) {
          Get.snackbar("Error", "$e");
        }
      } else {
        Get.snackbar("Error", "Password tidak boleh sama!");
      }
    } else {
      Get.snackbar("Error", "Password wajib diisi!");
    }
  }
}
