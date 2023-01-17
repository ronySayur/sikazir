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
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        //jika user tidak ada
        if (userCredential.user != null) {
          //jika email sudah di verifikasi
          if (userCredential.user!.emailVerified == true) {
            //jika pass masih 111111
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
                    "akun belum di Verifikasi. kirim verifikasi sekarang!",
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: wSmallText(text: "Batal")),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          Get.snackbar(
                            backgroundColor: Colors.white,
                            "Berhasil",
                            "Cek Email anda!",
                          );
                          await userCredential.user!.sendEmailVerification();
                          Get.back();
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
          Get.snackbar(
              backgroundColor: Colors.white,
              "Terjadi Kesalahan!",
              "Email tidak terdaftar");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Get.snackbar(
              backgroundColor: Colors.white,
              "Terjadi Kesalahan!",
              "Password salah!");
        }
      } catch (e) {
        print('$e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan!", "Email dan password wajib diisi",
          backgroundColor: Colors.white);
    }
  }
}
