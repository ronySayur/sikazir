import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> updateProfile(String email) async {
    if (nameC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {"nama": nameC.text};
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$email/profile.$ext').putFile(file);

          String urlImage =
              await storage.ref('$email/profile.$ext').getDownloadURL();

          data.addAll({"foto": urlImage});
        }
        firestore.collection("pegawai").doc(email).update(data);

        image = null;

        Get.back();

        Get.snackbar("Berhasil", "Berhasil update profile",
            duration: const Duration(seconds: 2));
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat update profile($e)");
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> deleteProfile(String email) async {
    try {
      await firestore.collection("pegawai").doc(email).update({
        "foto": "noimage",
      });
      update();
      Get.back();
      Get.snackbar("Berhasil", "Delete foto Berhasil");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat hapus foto($e)");
    } finally {}
  }
}
