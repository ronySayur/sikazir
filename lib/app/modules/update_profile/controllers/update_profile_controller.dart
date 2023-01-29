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

  Future<void> updateProfile(String uid) async {
    if (nameC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {"nama": nameC.text};
// "email_pegawai": emailC.text,
//             "nama_pegawai": nameC.text,
//             "jabatan": jabatanC.value,
//             "telepon": teleponC.text,
//             "foto": urlImage,
//             "pin": "111111",
//             "uid": uid,
//             "role": "pegawai",
//             "createdAt": DateTime.now().toIso8601String()
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$uid/profile.$ext').putFile(file);
        
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          data.addAll({"profile": urlImage});
        
        }
        firestore.collection("pegawai").doc(uid).update(data);
        
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

  Future<void> deleteProfile(String uid) async {
    try {
      await firestore.collection("pegawai").doc(uid).update({
        "profile": FieldValue.delete(),
      });
      update();
      Get.back();
      Get.snackbar("Berhasil", "Delete Profile Berhasil");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat delete profile($e)");
    } finally {}
  }
}
