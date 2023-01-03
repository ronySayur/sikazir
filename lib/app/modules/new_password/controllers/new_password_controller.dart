import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void newPaswword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          //ambil data email
          String email = auth.currentUser!.email!;

          //update password
          await auth.currentUser!.updatePassword(newPassC.text);

          //logout
          await auth.signOut();

          //Login
          auth.signInWithEmailAndPassword(
            email: email,
            password: newPassC.text,
          );

          //Close semua pindah Home
          Get.offAllNamed(Routes.HOME);
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
        Get.snackbar("Error", "Ubah password anda!");
      }
    } else {
      Get.snackbar("Error", "Password wajib diisi!");
    }
  }
}
