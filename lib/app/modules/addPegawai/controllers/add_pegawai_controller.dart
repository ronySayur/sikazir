// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jabatanC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController hakC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> prosesAddPegawai() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        jabatanC.text.isNotEmpty &&
        teleponC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        UserCredential pegawaiCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );

        String uid = pegawaiCredential.user!.uid;

        //Input ke firestore
        if (pegawaiCredential.user != null) {
          try {
            if (image != null) {
              File file = File(image!.path);
              String ext = image!.name.split(".").last;

              await storage.ref('$uid/profile.$ext').putFile(file);

              String urlImage =
                  await storage.ref('$uid/profile.$ext').getDownloadURL();

              firestore.collection("pegawai").doc(uid).set({
                "name": nameC.text,
                "jabatan": jabatanC.text,
                "telepon": teleponC.text,
                "hak": hakC.text,
                "profile": "urlImage",
                "password": "password",
                "email": emailC.text,
                "uid": uid,
                "role": "pegawai",
                "createdAt": DateTime.now().toIso8601String()
              });
            }

            await pegawaiCredential.user!.sendEmailVerification();

            await auth.signOut();

            await auth.signInWithEmailAndPassword(
              email: emailAdmin,
              password: passAdminC.text,
            );
          } catch (e) {
            Get.snackbar("Terjadi Kesalahan", "Tidak dapat update profile($e)");
          }

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "Berhasil menambahkan data pegawai");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Peringatan", "Password yang digunakan terlalu lemah");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Peringatan", "Akun sudah ada");
          print('The account already exists for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Admin tidak dapat login. password salah");
        } else {
          Get.snackbar("Terjadi Kesalahan", e.code);
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Semua form wajib diisi");
    }
  }

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
          title: "Valdiasi admin",
          content: Column(
            children: [
              wSmallText(text: "masukan password untuk validasi"),
              SizedBox(height: wDimension.height10),
              TextField(
                controller: passAdminC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              ),
              OutlinedButton(
                  onPressed: () async {
                    isLoading.value = false;
                    Get.back();
                  },
                  child: Text("Cancel")),
              Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (isLoadingAddPegawai.isFalse) {
                      await prosesAddPegawai();
                    }
                    isLoading.value = false;
                  },
                  child: Text(isLoadingAddPegawai.isFalse
                      ? "Add Pegawai"
                      : "Loading..")))
            ],
          ));
    } else {
      Get.snackbar("Error", "Terjadi kesalahan");
    }
  }
}
