import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class AddPegawaiController extends GetxController {
  //Factorismo Home
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jabatanC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController hakC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );

        //Input ke firestore
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          firestore.collection("pegawai").doc(uid).set({
            "name": nameC.text,
            "jabatan": jabatanC.text,
            "telepon": teleponC.text,
            "hak": hakC.text,
            "password": "password",
            "email": emailC.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String()
          });

          await userCredential.user!.sendEmailVerification();

          Get.offAllNamed(Routes.HOME);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Peringatan", "Password yang digunakan terlalu lemah");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Peringatan", "Akun sudah ada");
        }
      } catch (e) {
        Get.snackbar("Peringatan", "$e");
      }
    } else {
      Get.snackbar("Error", "Terjadi kesalahan");
    }
  }
}
