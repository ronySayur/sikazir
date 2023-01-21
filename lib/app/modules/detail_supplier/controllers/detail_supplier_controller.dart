import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailSupplierController extends GetxController with StateMixin {
  String? uid;
  RxBool isLoading = false.obs;

  final TextEditingController vendorNama = TextEditingController();
  final TextEditingController vendorTelp = TextEditingController();
  final TextEditingController vendorAlamat = TextEditingController();
  final TextEditingController vendorEmail = TextEditingController();
  final TextEditingController picJabatan = TextEditingController();
  final TextEditingController picNama = TextEditingController();
  final TextEditingController picTelp = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateSup(String idSup) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> dataSup = {
        "email_vendor": vendorNama.text,
        "no_pic": vendorTelp.text,
        "alamat_vendor": vendorAlamat.text,
        "jabatan_pic": vendorEmail.text,
        "nama_pic": picJabatan.text,
        "nama_vendor": picNama.text,
        "no_vendor": picTelp.text,
      };

      await firestore.collection("produk").doc(idSup).update(dataSup);

      Get.back();
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
