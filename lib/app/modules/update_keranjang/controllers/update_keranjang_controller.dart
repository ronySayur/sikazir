import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/widgets/widgets.dart';

class UpdateKeranjangController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController namaDiskon = TextEditingController();
  final TextEditingController diskon = TextEditingController();

  var pakaiDiskon = false.obs;

  final box = GetStorage();

  var emailPegawai = "".obs;
  var namaProduk = "".obs;
  var hargaJual = "".obs;

  var jumlah = 0.obs;
  var total = 0.obs;
  var diskonproduk = 0.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduk() {
    return firestore.collection("produk").snapshots();
  }

  increment(String idProduk) async {
    var dataProduk = await firestore.collection("produk").doc(idProduk).get();
    final hjual = int.parse(hargaJual.value.replaceAll(RegExp('[^0-9]'), ''));
    var diskonparse = diskon.text.isEmpty
        ? 0
        : int.parse(diskon.text.replaceAll(RegExp('[^0-9]'), ''));

    if (dataProduk.get("stok") > 0) {
      diskonproduk.value = diskonparse;
      jumlah.value += 1;
      total.value = (hjual * jumlah.value) - diskonproduk.value;

      loading();
      await firestore
          .collection("produk")
          .doc(idProduk)
          .update({"stok": FieldValue.increment(-1)});

      await firestore
          .collection("keranjang")
          .doc("$emailPegawai")
          .collection('produk')
          .doc(namaProduk.value)
          .update({
        "total_harga": FieldValue.increment(hjual),
        "jumlah": FieldValue.increment(1),
        "diskon": diskon.text.isEmpty ? 0 : diskonparse,
        "nama_diskon": namaDiskon.text.isEmpty ? "nodiskon" : namaDiskon.text,
      });
      Get.back();
    } else {
      Get.snackbar("Peringatan", "Produk Habis!",
          backgroundColor: Colors.white, duration: const Duration(seconds: 1));
    }
  }

  decrement(String idProduk) async {
    final hjual = int.parse(hargaJual.value.replaceAll(RegExp('[^0-9]'), ''));
    var diskonparse = diskon.text.isEmpty
        ? 0
        : int.parse(diskon.text.replaceAll(RegExp('[^0-9]'), ''));

    if (jumlah.value > 1) {
      jumlah.value -= 1;
      diskonproduk.value = diskonparse;
      total.value = (hjual * jumlah.value) - diskonproduk.value;

      loading();
      await firestore
          .collection("produk")
          .doc(idProduk)
          .update({"stok": FieldValue.increment(1)});

      await firestore
          .collection("keranjang")
          .doc("$emailPegawai")
          .collection('produk')
          .doc(namaProduk.value)
          .update({
        "total_harga": FieldValue.increment(hjual * -1),
        "jumlah": FieldValue.increment(-1),
        "diskon": diskon.text.isEmpty ? 0 : diskonparse,
        "nama_diskon": namaDiskon.text.isEmpty ? "nodiskon" : namaDiskon.text,
      });
      Get.back();
    }
  }

  Future<void> updateKeranjang(String idProduk) async {
    await firestore
        .collection("keranjang")
        .doc("$emailPegawai")
        .collection('produk')
        .doc(namaProduk.value)
        .update({
      "total_harga": total.value,
      "jumlah": jumlah.value,
      "diskon": diskon.text.isEmpty
          ? 0
          : int.parse(diskon.text.replaceAll(RegExp('[^0-9]'), '')),
      "nama_diskon": namaDiskon.text.isEmpty ? "nodiskon" : namaDiskon.text,
    });
  }

  Future<void> deleteKeranjang(String idProduk) async {
    loading();

    await firestore
        .collection("produk")
        .doc(idProduk)
        .update({"stok": FieldValue.increment(jumlah.value)});

    await firestore
        .collection("keranjang")
        .doc("$emailPegawai")
        .collection('produk')
        .doc(namaProduk.value)
        .delete();

    //close loading
    Get.back();
    //close confirm
    Get.back();
    //back to transaksi
    Get.back();
  }
}
