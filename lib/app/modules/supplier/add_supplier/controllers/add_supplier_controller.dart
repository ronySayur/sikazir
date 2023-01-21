import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSupplierController extends GetxController with StateMixin {
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamSup() async* {
    yield* firestore.collection("supplier").doc().snapshots();
  }

  Future<void> addSup() async {
    if (isLoading.isFalse) {
      if (vendorNama.text.isNotEmpty &&
          vendorTelp.text.isNotEmpty &&
          vendorEmail.text.isNotEmpty &&
          vendorAlamat.text.isNotEmpty &&
          picJabatan.text.isNotEmpty &&
          picNama.text.isNotEmpty &&
          picTelp.text.isNotEmpty) {
        isLoading(true);

        Map<String, dynamic> hasil = await afterAddSup({
          "keyName": vendorNama.text.substring(0, 1).toUpperCase(),
          "id_supplier": "id",
          "nama_vendor": vendorNama.text,
          "email_vendor": vendorEmail.text,
          "alamat_vendor": vendorAlamat.text,
          "no_vendor": vendorTelp.text,
          "nama_pic": picNama.text,
          "no_pic": picTelp.text,
          "jabatan_pic": picJabatan.text,
        });

        isLoading(false);
        Get.back();
        Get.back();
        await Future.delayed(Duration(seconds: 3));
        Get.snackbar(
            hasil["error"] == true ? "Error" : "Success", hasil["message"]);
      } else {
        Get.snackbar("Error", "Semua data wajib diisi.");
      }
    }
  }

  Future<Map<String, dynamic>> afterAddSup(Map<String, dynamic> data) async {
    try {
      var supplier = await firestore.collection("supplier").add(data);

      await firestore
          .collection("supplier")
          .doc(supplier.id)
          .update({"id_supplier": supplier.id});

      return {
        "error": false,
        "message": "Berhasil menambah product.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak dapat menambah product.",
      };
    }
  }
}
