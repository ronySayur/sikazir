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
        "email_vendor": vendorEmail.text,
        "no_pic": picTelp.text,
        "alamat_vendor": vendorAlamat.text,
        "jabatan_pic": picJabatan.text,
        "nama_pic": picNama.text,
        "nama_vendor": vendorNama.text,
        "no_vendor": vendorTelp.text,
      };

      await firestore.collection("supplier").doc(idSup).update(dataSup);

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
  
  Future<Map<String, dynamic>> deleteSup(String IDdelete) async {

    try {
      await firestore.collection("produk").doc(IDdelete).delete();

      Get.back();
      Get.back();
      Get.back();

      return {
        "error": false,
        "message": "Produk berhasil dihapus.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Produk gagal dihapus.",
      };
    }
  }
}
