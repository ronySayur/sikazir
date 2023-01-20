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

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController hakC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
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

  Future<void> prosesAddPegawai() async {
    isLoadingAddPegawai.value = true;
    try {
      String emailAdmin = auth.currentUser!.email!;

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

          firestore.collection("pegawai").doc(uid).set({
            "email": emailC.text,
            "nama_pegawai": nameC.text,
            "jabatan": jabatanC.value,
            "telepon": teleponC.text,
            "hak": hakC.text,
            "foto": urlImage,
            "password": "111111",
            "uid": uid,
            //TODO 
            "role": "pegawai",
            "createdAt": DateTime.now().toIso8601String()
          });

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
        Get.snackbar("Terjadi Kesalahan", "Password salah");
        isLoading.value = false;
      } else {
        Get.snackbar("Terjadi Kesalahan", e.code);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPegawai() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        jabatanC.value.isNotEmpty &&
        teleponC.text.isNotEmpty &&
        image != null) {
      isLoading.value = true;
      await konfirmasiDialog();
    } else {
      Get.snackbar("Error", "Semua form dan foto harap diisi terlebih dahulu");
    }
  }

  konfirmasiDialog() async {
    Get.defaultDialog(
        title: "Valdiasi admin",
        content: Column(
          children: [
            wSmallText(text: "masukan password untuk validasi"),
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
                labelStyle: TextStyle(
                    color: Colors.black, fontSize: wDimension.font16),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(wDimension.radius30 * 10),
                    borderSide: const BorderSide(color: Colors.red)),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(wDimension.radius30 * 10),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: wDimension.width30,
                  vertical: wDimension.width15,
                ),
              ),
            ),
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
                    isLoading.value = false;
                  }
                },
                child: Text(isLoadingAddPegawai.isFalse
                    ? "Add Pegawai"
                    : "Loading..")))
          ],
        ));
  }



  
  }

