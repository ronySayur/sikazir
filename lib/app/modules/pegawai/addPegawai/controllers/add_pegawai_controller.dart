// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sikasir/widgets/widgets.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  TextEditingController nameC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController hakC = TextEditingController();
  TextEditingController pinC = TextEditingController();

  final jabatanC = "".obs;

  String? uid;

  final List<String> items = [
    'Supervisor',
    'Kasir',
    'Admin Gudang',
  ].obs;

  void setSelected(String value) {
    jabatanC.value = value;
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> addPegawai() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        teleponC.text.isNotEmpty &&
        image != null) {
      isLoading.value = true;
      await konfirmasiDialog();
    } else {
      //matikan loading()
      Get.back();
      Get.snackbar("Error", "Semua Form dan Foto harap diisi terlebih dahulu");
    }
  }

  konfirmasiDialog() async {
    Get.back();
    Get.defaultDialog(
        title: "Valdiasi admin",
        content: Column(
          children: [
            wSmallText(text: "Masukan password untuk validasi"),
            SizedBox(height: wDimension.height10),
            TextField(
              controller: passAdminC,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.done,
              maxLength: 6,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Pin",
                counterText: "",
                labelStyle:
                    TextStyle(color: Colors.black, fontSize: wDimension.font16),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(wDimension.radius30 * 10),
                    borderSide: const BorderSide(color: Colors.red)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(wDimension.radius30 * 10),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: wDimension.width30,
                  vertical: wDimension.width15,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                OutlinedButton(
                    onPressed: () async {
                      isLoading.value = false;
                      Get.back();
                    },
                    child: const Text("Batal")),
                Obx(() => ElevatedButton(
                    onPressed: () async {
                      if (isLoadingAddPegawai.isFalse) {
                        await prosesAddPegawai();
                      }
                    },
                    child: Text(isLoadingAddPegawai.isFalse
                        ? "Add Pegawai"
                        : "Loading..")))
              ],
            ),
          ],
        ));
  }

  Future<void> prosesAddPegawai() async {
    loading();
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
        password: "111111",
      );

      uid = pegawaiCredential.user!.uid;

      //Input ke firestore
      if (pegawaiCredential.user != null) {
        try {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$uid/profile.$ext').putFile(file);

          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          await firestore.collection("pegawai").doc(emailC.text).set({
            "email_pegawai": emailC.text,
            "nama_pegawai": nameC.text,
            "jabatan": jabatanC.value,
            "telepon": teleponC.text,
            "hak": hakC.text,
            "foto": urlImage,
            "pin": "111111",
            "role": "pegawai",
            "createdAt": DateTime.now().toIso8601String()
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: emailAdmin, password: passAdminC.text);
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat update profile($e)");
        } finally {
          isLoading.value = false;
        }

        Get.back();
        Get.back();
        Get.back();
        Get.snackbar("Berhasil", "Berhasil menambahkan data pegawai");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Get.back();
        Get.snackbar("Peringatan", "Password yang digunakan terlalu lemah");
        isLoading.value = false;
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        Get.back();

        Get.snackbar("Peringatan", "Akun sudah ada");
        isLoading.value = false;
      } else if (e.code == 'wrong-password') {
        Get.back();
        Get.snackbar("Terjadi Kesalahan", "Password salah");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.back();
        Get.back();
        Get.snackbar("Terjadi Kesalahan", e.code);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
