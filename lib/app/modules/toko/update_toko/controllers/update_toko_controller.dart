import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

class UpdateTokoController extends GetxController {
    
  String? uid;
  RxBool isLoading = false.obs;

  final TextEditingController namaToko = TextEditingController();
  final TextEditingController telpToko = TextEditingController();
  final TextEditingController alamatToko = TextEditingController();
  final TextEditingController emailToko = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateToko(String idToko) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> dataToko = {
          "nama_toko": namaToko.text,
          "email_toko": emailToko.text,
          "alamat": alamatToko.text,
          "no_telp": telpToko.text      };


loading();
      await firestore.collection("toko").doc(idToko).update(dataToko);
      Get.back();

      Get.back();
      Get.snackbar("Berhasil", "Berhasil update toko",
          duration: const Duration(seconds: 2));
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat update toko($e)");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> deleteToko(String idDelete) async {
    try {
      loading();
      await firestore.collection("toko").doc(idDelete).delete();
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