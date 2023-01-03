import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/widgets.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        //Verifikasi email
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          }
        } else {
          Get.defaultDialog(
              title: "Peringatan",
              middleText: "akun belum terverifikasi",
              actions: [
                OutlinedButton(
                    onPressed: () => Get.back(),
                    child: wSmallText(text: "Cancel")),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.snackbar("Berhasil", "Cek Email anda!");
                      } catch (e) {
                        Get.snackbar("Error", "$e");
                      }
                    },
                    child: wSmallText(text: "Cancel")),
              ]);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan!", "Email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan!", "Password salah!");
        }
      } catch (e) {
        print('$e');
      }
    } else {
      Get.snackbar("Terjadi Kesalahan!", "Email dan password wajib diisi");
    }
  }
}
