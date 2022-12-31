import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  //Factorismo Home
  TextEditingController nameC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jabatanC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController hakC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPegawai() async {
    if (passC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );

        //Input ke firestore
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          firestore.collection("pegawai").doc(uid).set({
            "nip": passC.text,
            "name": nameC.text,
            "password": "password",
            "email": emailC.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String()
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Peringatan", "Password yang digunakan terlalu lemah");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Peringatan", "Akun sudah ada");
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      Get.snackbar("Error", "Terjadi kesalahan");
    }
  }
}
