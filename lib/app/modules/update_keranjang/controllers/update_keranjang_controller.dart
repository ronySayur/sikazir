import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/widgets/widgets.dart';

class UpdateKeranjangController extends GetxController {
  final TextEditingController namaDiskon = TextEditingController();
  final TextEditingController diskon = TextEditingController();
  RxBool isLoading = false.obs;
  var pakaiDiskon = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final box = GetStorage();

  var emailPegawai = "".obs;
  var namaProduk = "".obs;
  var jumlah = 0.obs;
  var hargaJual = "".obs;
  var total = 0.obs;
  var subtotal = 0.obs;
  var diskonproduk = 0.obs;

  increment() {
    jumlah.value += 1;
    final hargaJ = int.parse(hargaJual.replaceAll(RegExp('[^0-9]'), ''));
    total.value = jumlah.value * hargaJ;
  }

  decrement() {
    jumlah.value -= 1;
    final hargaJ = int.parse(hargaJual.replaceAll(RegExp('[^0-9]'), ''));
    total.value = jumlah.value * hargaJ;
  }

  Future<void> updateKeranjang() async {
    loading();
    try {
      firestore
          .collection("keranjang")
          .doc("$emailPegawai")
          .collection('produk')
          .doc(namaProduk.value)
          .update({"total_harga": total.value, "jumlah": jumlah.value});
      Get.back();
      Get.back();
    } catch (e) {
      Get.back();

      Get.snackbar("Terjadi Kesalahan", "Tidak dapat update toko($e)");
    }
  }

  Future<Map<String, dynamic>> deleteKeranjang() async {
    loading();
    try {
      await firestore
          .collection("keranjang")
          .doc("$emailPegawai")
          .collection('produk')
          .doc(namaProduk.value)
          .delete();
      Get.back();
      Get.back();
      return {
        "error": false,
        "message": "Produk berhasil dihapus.",
      };
    } catch (e) {
      Get.back();

      return {
        "error": true,
        "message": "Produk gagal dihapus.",
      };
    }
  }
}
