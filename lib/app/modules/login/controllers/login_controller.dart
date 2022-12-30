import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //Factorismo Home
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        // //Verifikasi email
        // if (userCredential.user != null) {
        //   if (userCredential.user!.emailVerified == true) {
        //     Get.offAllNamed(Routes.HOME);
        //   }
        // } else {
        //   Get.defaultDialog(
        //       title: "Peringatan", middleText: "akun belum terverifikasi");
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan!", "Email tidak terdaftar");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
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
