import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/widgets.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        loading();
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        Get.back();
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            if (passC.text == "111111") {
              Get.snackbar(
                  backgroundColor: Colors.white,
                  "Peringatan",
                  "Ubah password anda");
              
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: "Peringatan",
                middleText:
                    "akun belum di Verifikasi. Kirim verifikasi sekarang!",
                actions: [
                  OutlinedButton(
                      onPressed: () async {
                        await auth.signOut();
                        Get.back();
                      },
                      child: wSmallText(text: "Batal")),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          loading();
                          await userCredential.user!.sendEmailVerification();
                          await auth.signOut();
                          Get.back();

                          Get.snackbar(
                            backgroundColor: Colors.white,
                            "Berhasil",
                            "Cek Email anda!",
                          );
                        } catch (e) {
                          Get.snackbar(
                              backgroundColor: Colors.white, "Error", "$e");
                        }
                      },
                      child: wSmallText(
                        text: "Kirim",
                        color: Colors.white,
                      )),
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.back();
          Get.snackbar(
              backgroundColor: Colors.white,
              "Terjadi Kesalahan!",
              "Email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.back();
          Get.snackbar(
              backgroundColor: Colors.white,
              "Terjadi Kesalahan!",
              "Password salah!");
        }
      } catch (e) {
        Get.back();
        Get.snackbar(backgroundColor: Colors.white, "Terjadi Kesalahan!", '$e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.back();
      Get.snackbar("Terjadi Kesalahan!", "Email dan password wajib diisi",
          backgroundColor: Colors.white);
    }
  }
}
